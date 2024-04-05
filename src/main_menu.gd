extends CanvasLayer

@export var lobby_scene: PackedScene

func _on_host_pressed():
	change_scene_to_lobby(true)

func _on_join_pressed():
	change_scene_to_lobby(false)

func change_scene_to_lobby(is_host: bool):
	var lobby = lobby_scene.instantiate() as Lobby
	lobby.is_host = is_host
	ChangeSceneUtilities.change_scene_to_instance(lobby, get_tree())
