extends CanvasLayer

class_name Lobby

@export var client_scene: PackedScene
@export var server_scene: PackedScene
@export var player_list_container: VBoxContainer
@export var player_list_item_scene: PackedScene

var _client: Client

var is_host: bool = false

func _ready():
	if is_host:
		add_child(server_scene.instantiate())
	
	_client = client_scene.instantiate() as Client
	_client.player_list_updated.connect(on_player_list_updated)
	_client.server_disconnected.connect(on_server_disconnected)
	add_child(_client)

func on_player_list_updated(players: Array):
	clear_player_list()
	add_players_to_player_list(players)

func on_server_disconnected():
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_leave_button_pressed():
	_client.disconnect_client()
	get_tree().change_scene_to_file("res://main_menu.tscn")

func clear_player_list():
	for player_list_item in player_list_container.get_children():
		player_list_container.remove_child(player_list_item)
		player_list_item.queue_free()

func add_players_to_player_list(players: Array):
	for player in players:
		var player_list_item = player_list_item_scene.instantiate() as PlayerListItem
		player_list_item.player_name = str(player)
		player_list_item.show_kick_button = is_host
		player_list_item.kick_pressed.connect(on_kick_pressed)
		player_list_container.add_child(player_list_item)

func on_kick_pressed(player_id: int):
	_client.attempt_to_disconnect_player(player_id)
