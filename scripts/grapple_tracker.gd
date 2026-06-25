extends Node
class_name GrappleTracker
@export var level : Level
@export var player : Player
@export var second_view : SecondView
var all_hookables : Array[Hookable]

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
	for object : Hookable in get_children():
		all_hookables.append(object)
		object.tree_exiting.connect(_on_grapple.bind(object))

func _on_grapple(from : Node):
	all_hookables.erase(from)
	if all_hookables.size() == 0:
		level.win()

func _process(_delta: float) -> void:
	closest_objective = _get_closest_objective()

func _get_closest_objective() -> Node2D:
	var current_closest : Node2D
	for objective in all_hookables:
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
