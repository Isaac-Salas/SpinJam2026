extends Node
class_name ExtinguishTracker
@export var level : Level
@export var player : Player
@export var second_view : SecondView
@export var all_extinguishables : Array[Extinguishable]

var closest_objective : Node2D:
	set(value):
		if value != closest_objective:
			closest_objective = value
			closest_objective_changed.emit(closest_objective)

signal closest_objective_changed(value : Node2D)

func _ready() -> void:
	_initialize_all_extinguishables()
	closest_objective_changed.connect(_update_second_view_to_target)

func _initialize_all_extinguishables():
	for fire in all_extinguishables:
		fire.tree_exiting.connect(_on_extinguish.bind(fire))

func _on_extinguish(from : Node):
	all_extinguishables.erase(from)
	if all_extinguishables.size() == 0:
		level.win()

func _process(_delta: float) -> void:
	closest_objective = _get_closest_objective()

func _get_closest_objective() -> Node2D:
	var current_closest : Node2D
	for objective in all_extinguishables:
		@warning_ignore("unassigned_variable")
		if current_closest == null:
			current_closest = objective
		var objective_distance = objective.global_position.distance_to(player.global_position)
		var compare_distance = current_closest.global_position.distance_to(player.global_position)
		if objective_distance < compare_distance:
			current_closest = objective
	return current_closest

func _update_second_view_to_target(new_target : Node2D):
	second_view.tracking_cam.target_follow = new_target
