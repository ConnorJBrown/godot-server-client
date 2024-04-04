extends CanvasLayer

@export var client_scene: PackedScene
@export var server_scene: PackedScene

func _on_host_pressed():
	var server = server_scene.instantiate() as Server
	add_child(server)
	
	var client = client_scene.instantiate() as Client
	client.player_list_updated.connect(on_player_list_updated)
	add_child(client)

func _on_join_pressed():
	var client = client_scene.instantiate() as Client
	client.player_list_updated.connect(on_player_list_updated)
	add_child(client)

func on_player_list_updated(players: Array):
	var label = $VBoxContainer/Label as Label
	label.text = "Connected peers: " + str(players)
