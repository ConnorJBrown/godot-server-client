extends Node

class_name Server

var peer_list: Array[int] = []

func _ready():
	var server = ENetMultiplayerPeer.new()
	get_tree().set_multiplayer(MultiplayerAPI.create_default_interface(), get_path())
	multiplayer.peer_connected.connect(on_peer_connected)
	server.create_server(1500)
	multiplayer.multiplayer_peer = server

func on_peer_connected(id: int):
	peer_list.append(id)
	sync_player_list.rpc(peer_list)

@rpc("authority", "call_remote", "reliable")
func sync_player_list(peers: Array):
	pass
