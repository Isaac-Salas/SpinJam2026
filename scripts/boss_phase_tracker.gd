extends Node
class_name BossTrackerExtinguish
@export var tracker : ExtinguishTracker
@export var phases_random_amount : Array[int]
@export var phases_limit_time : Array[float]
@export var time_label : ExtinguishCountdown
@export var follow_target : FollowTarget
@export var get_him_label : Label
@export var boss : Robot
@export var down_position : Marker2D
@export var fly_position : Marker2D
@export var head_flames : Array[Extinguishable]
@export var level : Level
var current_phase : int = 0



func _ready() -> void:
	level.music_started.connect(_activate_phase.bind(true))
	tracker.phase_done.connect(_on_phase_done)
	level.level_lost.connect(self.queue_free)


func _on_phase_done():
	_make_boss_hittable()

func _make_boss_hittable():
	update_lable_phase_done(true)
	_second_cam_track_boss()
	_bring_boss_down()
	_toggle_follow_player(false)
	_activate_head_flame()

func _make_boss_return():
	head_flames.remove_at(0)
	var win : bool = _evaluate_win()
	if not win:
		update_lable_phase_done(false)
		await _return_boss_up()
		_activate_phase(true)
	

func update_lable_phase_done(value : bool):
	if time_label:
		time_label.toggle_visibility(not value)
		get_him_label.visible = value

func _second_cam_track_boss():
	tracker.update_second_view_to_target(boss)

func _bring_boss_down():
	tween_position(down_position.global_position)

func _return_boss_up():
	tween_position(fly_position.global_position)

func tween_position(target_position : Vector2):
	var tween : Tween = create_tween()
	tween.tween_property(boss,"global_position",target_position,1.0)
	await tween.finished
	tween.kill()

func _toggle_follow_player(value : bool):
	follow_target.follow_x = value

func _activate_phase(reset_timer : bool):
	if tracker:
		tracker.activate_random_fire(phases_random_amount[current_phase])
	if reset_timer:
		tracker._reset_timer(phases_limit_time[current_phase])
	if current_phase < phases_random_amount.size() -1:
		current_phase += 1

func _activate_head_flame():
	head_flames[0].toggle_visibility(true)
	head_flames[0].toggle_detection(true)
	head_flames[0].tree_exiting.connect(_make_boss_return)

func _evaluate_win() -> bool:
	if head_flames.size() == 0:
		level.win()
		self.queue_free()
		return true
	else:
		return false
