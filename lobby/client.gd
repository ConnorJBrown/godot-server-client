extends Node

class_name Client

signal player_list_updated(players: Array)
signal server_disconnected

func _ready():
	get_tree().set_multiplayer(MultiplayerAPI.create_default_interface(), get_path())
	multiplayer.server_disconnected.connect(on_server_disconnected)
	
	var client = ENetMultiplayerPeer.new()
	client.create_client("127.0.0.1", 1500)
	multiplayer.multiplayer_peer = client

func on_server_disconnected():
	disconnect_client()
	server_disconnected.emit()

func disconnect_client():
	multiplayer.multiplayer_peer.close()
	multiplayer.multiplayer_peer = null

func attempt_to_disconnect_player(id: int):
	_request_kick_player.rpc_id(1, id)

@rpc("authority", "call_remote", "reliable")
func _sync_player_list(peers: Array):
	print("[Client " + str(multiplayer.get_unique_id()) + "] Syncing player list: " + str(peers))
	player_list_updated.emit(peers)

@rpc("any_peer", "call_remote", "reliable")
func _request_kick_player(id: int):
	pass
