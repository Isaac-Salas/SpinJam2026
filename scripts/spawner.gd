extends Node2D
class_name Spawner
@export var spawn_scene : PackedScene
@onready var spawn_here: Marker2D = $SpawnHere
@onready var spawn_manager: SpawnManager = $".."

signal spawned(object : Node2D)

func spawn(packed : PackedScene = spawn_scene):
	var new_instance : Node2D = packed.instantiate()
	spawn_manager.add_child.call_deferred(new_instance)
	new_instance.set_deferred("global_position",spawn_here.global_position)
	spawned.emit(new_instance)
	return
