extends Node2D
class_name SpawnManager
var all_spawners : Array[Spawner]
var spawned_objects : Array[Node2D]

signal object_spawned (object : Node2D)
signal object_despawned (object : Node2D)
signal all_despawned


func _get_spawners_and_connect():
	for child in get_children():
		if child is Spawner:
			all_spawners.append(child)
			child.spawned.connect(_update_spawned_objects)

func _update_spawned_objects(new_object : Node2D):
	new_object.tree_exiting.connect(_on_spawned_exiting_tree.bind(new_object))
	spawned_objects.append(new_object)
	object_spawned.emit(new_object)


func _on_spawned_exiting_tree(from : Node):
	if from.is_queued_for_deletion():
		spawned_objects.erase(from)
		object_despawned.emit(from)
		if spawned_objects.size() == 0:
			all_despawned.emit()
