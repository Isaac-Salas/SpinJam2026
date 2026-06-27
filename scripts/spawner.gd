extends Node2D
class_name Spawner
@export var spawn_scene : PackedScene
@export var spawn_manager : SpawnManager
@onready var spawn_here: Marker2D = $SpawnHere

signal spawned(object : Node2D)



func spawn():
	var new_instance : Node2D = spawn_scene.instantiate()
	spawn_manager.add_child.call_deferred(new_instance)
	new_instance.global_position = spawn_here.global_position
	spawned.emit(new_instance)
	return
