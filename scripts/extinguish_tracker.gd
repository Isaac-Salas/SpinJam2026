extends Node
class_name ExtinguishTracker
@export var randomize_active_extinguishables : bool
@export var randomize_amount : int = 1
@export var extinguish_time_limit : bool
@export var limit_time_amount : float
@export var level : Level
@export var player : Player
@export var second_view : SecondView
@export var all_extinguishables : Array[Extinguishable]
@onready var limit_timer: Timer = $LimitTimer


var closest_objective : Node2D:
	set(value):
		if value != closest_objective:
			closest_objective = value
			closest_objective_changed.emit(closest_objective)

signal target_extinguished
signal closest_objective_changed(value : Node2D)
signal finished

func _ready() -> void:
	if randomize_active_extinguishables:
		activate_random_fire(randomize_amount)
		target_extinguished.connect(_on_extinguished_random)
	if extinguish_time_limit:
		level.music_started.connect(_reset_timer.bind(limit_time_amount))
		target_extinguished.connect(_reset_timer.bind(limit_time_amount))
		limit_timer.timeout.connect(_on_limit_timeout)
		finished.connect(limit_timer.stop)
	update_all_extinguishables()
	closest_objective_changed.connect(_update_second_view_to_target)

func _process(_delta: float) -> void:
	closest_objective = _get_closest_objective()

func update_all_extinguishables():
	for fire : Extinguishable in all_extinguishables:
		if fire.active:
			fire.tree_exiting.connect(_on_extinguish.bind(fire))
		if not fire.active_changed.is_connected(update_all_extinguishables):
			fire.active_changed.connect(update_all_extinguishables)

func activate_random_fire(amount_of_times : int):
	for time in amount_of_times:
		if all_extinguishables.size() != 0:
			var ramdom_number : int = randi_range(0,all_extinguishables.size()-1)
			var new_target : Extinguishable = all_extinguishables[ramdom_number]
			new_target.toggle_detection(true)

func _on_extinguish(from : Node):
	all_extinguishables.erase(from)
	target_extinguished.emit()
	if all_extinguishables.size() == 0:
		level.win()
		finished.emit()

func _on_extinguished_random():
	activate_random_fire(randomize_amount)

func _get_closest_objective() -> Node2D:
	var current_closest : Node2D
	for objective in all_extinguishables:
		if objective.active:
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

func _reset_timer(value : float):
	limit_timer.start(value)

func _on_limit_timeout():
	level.lose()
	self.queue_free()
