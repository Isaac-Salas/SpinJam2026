extends Node2D
class_name Crosshair
@export var state_machine : PlayerStateMachine
@onready var _1: Sprite2D = $"1"
@onready var _2: Sprite2D = $"2"
@onready var _3: Sprite2D = $"3"

@export var segment_color_full : Color
@export var segment_color_transparent : Color

var original_scales : Array[Vector2]


func _ready() -> void:
	for child : Sprite2D in get_children():
		original_scales.append(child.scale)
	if state_machine:
		state_machine.state_changed.connect(_eval_croshair_visibility)

func _eval_croshair_visibility(current_state : State):
	var state_name : String = current_state.name.to_lower()
	if state_name == "shoot" or state_name == "aim" or state_name == "grapple":
		self.visible = true
		if state_name == "grapple":
			_swap_connection_mode(true)
		else:
			_swap_connection_mode(false)
	else:
		self.visible = false

func _on_count_changed(value : int):
	if value > 0 and value <= 3:
		_animate_part(value)
	elif value <= 0:
		_animate_part(1)

func _animate_part(segment_number : int):
	_reset_all_segments_visible()
	var target_name : String = "_" + str(segment_number)
	var target_segment : Sprite2D = get(target_name)
	target_segment.modulate = segment_color_full
	var original_scale : Vector2 = original_scales[segment_number-1]
	var new_scale := original_scale*1.5
	var tween : Tween = create_tween()
	tween.tween_property(target_segment,"scale",new_scale,0.05)
	tween.tween_property(target_segment,"scale",original_scale,0.05)
	await tween.finished
	tween.kill()

func _reset_all_segments_visible():
	_1.modulate = segment_color_transparent
	_2.modulate = segment_color_transparent
	_3.modulate = segment_color_transparent

func _swap_connection_mode(grapple : bool):
	_disconnect_all()
	if grapple:
		OverlayUI.wheel_view.energy_bar_updated.connect(_on_count_changed)
	else:
		OverlayUI.wheel_view.rotator.rotation_count_changed.connect(_on_count_changed)

func _disconnect_all():
	if OverlayUI.wheel_view.energy_bar_updated.is_connected(_on_count_changed):
		OverlayUI.wheel_view.energy_bar_updated.disconnect(_on_count_changed)
	if OverlayUI.wheel_view.rotator.rotation_count_changed.is_connected(_on_count_changed):
		OverlayUI.wheel_view.rotator.rotation_count_changed.disconnect(_on_count_changed)
