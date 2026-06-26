extends Node
class_name BossTrackerExtinguish
@export var tracker : ExtinguishTracker
@export var phases_random_amount : Array[int]
@export var time_label : ExtinguishCountdown
@export var get_him_label : Label
@export var boss : Robot
var current_phase : int = 0



func _ready() -> void:
	tracker.phase_done.connect(_on_phase_done)
	_activate_phase(false)


func _on_phase_done():
	print("DONE")
	update_lable_phase_done(true)
	_second_cam_track_boss()

func update_lable_phase_done(value : bool):
	if time_label:
		time_label.toggle_visibility(not value)
		get_him_label.visible = value

func _second_cam_track_boss():
	tracker.update_second_view_to_target(boss)

func _activate_phase(reset_timer : bool):
	if tracker.randomize_active_extinguishables:
		tracker.activate_random_fire(phases_random_amount[current_phase])
	if reset_timer:
		tracker._reset_timer(tracker.limit_time_amount)
	if current_phase < phases_random_amount.size() -1:
		current_phase += 1
