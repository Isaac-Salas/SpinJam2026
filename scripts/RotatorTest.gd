extends Node2D
class_name SpinningWheel
@onready var rotador: Node2D = $"."
@onready var wheel: Sprite2D = $Wheel
@onready var area_2d: Area2D = $Area2D
@onready var indicator: Sprite2D = $Area2D/Indicator
@export var rotation_speed : int = 6
@export var disable : bool = false
@onready var rotation_counter: Label = $RotationCounter


var is_dragging : bool = false
var mouse_click : bool = false
var start_rotating : bool = false
var previous_rotation_mouse : float = 0.0

var rotation_count : int = 0:
	set(value):
		if value != rotation_count:
			rotation_count = value
			rotation_count_changed.emit(rotation_count) 

var rotating_side : String:
	set(value):
		if value != rotating_side:
			rotating_side = value
			rotation_side_change.emit(rotating_side)

var add_rotations : bool:
	set(value):
		if value != add_rotations:
			add_rotations = value
			if add_rotations:
				_add_rotations()

var wheel_spinning : bool:
	set(value):
		if value != wheel_spinning:
			wheel_spinning = value
			is_wheel_spinning.emit(wheel_spinning)

signal rotation_side_change(side : String)
signal rotation_count_changed(count : int)
signal is_wheel_spinning(value : bool)

func _ready() -> void:
	
	area_2d.input_event.connect(_on_area_input)

func _input(event: InputEvent) -> void:
	if not disable:
		if event.is_action_pressed("left_click"):
			is_dragging = true
			
		elif event.is_action_released("left_click"):
			rotating_side = ""
			is_dragging = false
			mouse_click = false
			start_rotating = false
			wheel.reparent(rotador)
			wheel_spinning = false
			_reset_all()
		if event is InputEventMouseMotion:
			if is_dragging and mouse_click:
				#area_2d.look_at(get_global_mouse_position())
				start_rotating = true
				wheel_spinning = true
				wheel.reparent(area_2d)
				_check_turn_side()


func _process(delta: float) -> void:
	if start_rotating:
		_rotate_wheel(delta)
	_check_rotations()

func _rotate_wheel(delta : float):
	var target_pos = get_global_mouse_position()
	area_2d.rotation = lerp_angle(area_2d.rotation, area_2d.get_angle_to(target_pos), delta * rotation_speed)

func _reset_all():
	start_rotating = false
	is_dragging = false
	mouse_click = false
	rotation_count = 0
	area_2d.global_rotation = 0.0
	var tween : Tween = create_tween()
	wheel.global_rotation_degrees = wheel.global_rotation_degrees + 360
	tween.tween_property(wheel,"global_rotation_degrees",0,0.1)
	await tween.finished
	tween.kill()


func _on_area_input(_viewport : Node, event : InputEvent, _shape_idx : int):
	if event.is_action_pressed("left_click"):
		mouse_click = true
		

func _check_turn_side():
	previous_rotation_mouse = rad_to_deg(wheel.get_angle_to(get_global_mouse_position()))
	var current_rotation = wheel.global_rotation_degrees
	# Calculate difference, handling wrap-around at 360/0
	var diff = fmod(current_rotation - previous_rotation_mouse + 540.0, 360.0) - 180.0
	if diff > 0:
		rotating_side = "left"
	elif diff < 0:
		rotating_side = "right"
	previous_rotation_mouse = current_rotation

func _check_rotations():
	var rotation_check := wrapf(wheel.global_rotation_degrees, 0, 360.0)
	var quadrant = floor(fposmod(rotation_check, 360.0) / 90.0)
	match rotating_side:
		"right":
			if quadrant >= 2:
				add_rotations = true
			else:
				add_rotations = false
		"left":
			if quadrant <= 2:
				add_rotations = true
			else:
				add_rotations = false
	#print(quadrant)

func _add_rotations():
	match rotating_side:
		"right":
			rotation_count += 1
		"left":
			rotation_count -= 1

func toggle_disable(value):
	disable = value
	_reset_all()
