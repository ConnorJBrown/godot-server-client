extends Node

class_name ChangeSceneUtilities

static func change_scene_to_instance(instance: Node, tree: SceneTree) -> void:
	var root := tree.root
	var main_scene := root.get_children()[0]
	root.add_child(instance)
	tree.current_scene = instance
	root.remove_child(main_scene)
	main_scene.queue_free()
