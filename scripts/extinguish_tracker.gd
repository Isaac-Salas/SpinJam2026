extends Node
class_name ExtinguishTracker
@export var level : Level
@export var all_extinguishables : Array[Extinguishable]

func _ready() -> void:
	for fire in all_extinguishables:
		fire.tree_exiting.connect(_on_extinguish.bind(fire))
		

func _on_extinguish(from : Node):
	all_extinguishables.erase(from)
	if all_extinguishables.size() == 0:
		level.win()
