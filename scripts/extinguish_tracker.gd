extends Node
class_name ExtinguishTracker
@export var level : Level
@export var player : Player
@export var all_extinguishables : Array[Extinguishable]

func _ready() -> void:
	for fire in all_extinguishables:
		fire.tree_exiting.connect(_on_extinguish.bind(fire))
		

func _on_extinguish(from : Node):
	all_extinguishables.erase(from)
	if all_extinguishables.size() == 0:
		level.win()


func _process(delta: float) -> void:
	_check_closest_objective()

func _check_closest_objective():
	var current_compare : Node2D
	for objectives in all_extinguishables:
		pass
