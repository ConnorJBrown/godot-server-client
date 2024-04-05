extends Node

class_name Server

var peer_list: Array[int] = []
var host_id: int

var _server: ENetMultiplayerPeer

func _ready():
	get_tree().set_multiplayer(MultiplayerAPI.create_default_interface(), get_path())
	multiplayer.peer_connected.connect(on_peer_connected)
	multiplayer.peer_disconnected.connect(on_peer_disconnected)
	
	_server = ENetMultiplayerPeer.new()
	_server.create_server(1500)
	multiplayer.multiplayer_peer = _server

func _exit_tree():
	multiplayer.multiplayer_peer.close()
	multiplayer.multiplayer_peer = null

func on_peer_connected(id: int):
	if peer_list.is_empty():
		host_id = id
	peer_list.append(id)
	sync_client_player_list()

func on_peer_disconnected(id: int):
	if id == host_id:
		multiplayer.multiplayer_peer.close()
		multiplayer.multiplayer_peer = null
		peer_list.clear()
		return
	
	peer_list.erase(id)
	sync_client_player_list()

func sync_client_player_list():
	_sync_player_list.rpc(peer_list)

@rpc("authority", "call_remote", "reliable")
func _sync_player_list(peers: Array):
	pass

@rpc("any_peer", "call_remote", "reliable")
func _request_kick_player(id: int):
	var sender_id = multiplayer.get_remote_sender_id()
	if sender_id == host_id:
		_server.disconnect_peer(id)
