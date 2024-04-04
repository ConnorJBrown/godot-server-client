extends Node

class_name Client

signal player_list_updated(players: Array)

func _ready():
	get_tree().set_multiplayer(MultiplayerAPI.create_default_interface(), get_path())
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1", 1500)
	multiplayer.multiplayer_peer = peer

@rpc("authority", "call_remote", "reliable")
func sync_player_list(peers: Array):
	print("[Client " + str(multiplayer.get_unique_id()) + "] Syncing player list: " + str(peers))
	player_list_updated.emit(peers)
