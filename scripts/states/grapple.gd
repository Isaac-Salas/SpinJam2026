extends State
class_name Grapple
@export var crosshair : Crosshair
@export var energy_count : int
@export var max_limit : int = 3
@export var min_limit : int = 0
var arm : ArmGrapple

func Enter():
	arm = player.body_parts.arm_r_grapple
	_reset_arm_rotation()
	toggle_arm_and_hide_og(true)
	OverlayUI.wheel_view.tween_update_energy_bar(energy_count)
	OverlayUI.wheel_view.rotator.rotation_count_changed.connect(update_energy_count)
	OverlayUI.wheel_view.activate.pressed.connect(shoot_grapple)

func Exit():
	await _tween_reset_arm_rotation()
	toggle_arm_and_hide_og(false)
	OverlayUI.wheel_view.rotator.rotation_count_changed.disconnect(update_energy_count)
	OverlayUI.wheel_view.activate.pressed.disconnect(shoot_grapple)

func Update(_delta: float):
	var current_target_number : int
	if energy_count != 0:
		current_target_number = energy_count
	else:
		current_target_number = 1
	var current_target : Node2D = crosshair.get("_"+str(current_target_number))
	var target_angle = atan2(current_target.global_position.y - arm.global_position.y, 
	current_target.global_position.x - arm.global_position.x)
	arm.rotation = lerp_angle(arm.rotation,target_angle,_delta*5)

func shoot_grapple():
	reset_energy_count()
	_tween_shoot()
	print("grapple here!")

func toggle_arm_and_hide_og(value : bool):
	arm.visible = value
	player.body_parts.arm_r.visible = not value

func update_energy_count(value : int):
	if value != 0:
		energy_count += sign(value)
		energy_count = clamp(energy_count,min_limit,max_limit)
		OverlayUI.wheel_view.tween_update_energy_bar(energy_count)
	#print(energy_count)

func reset_energy_count():
	energy_count = 0
	OverlayUI.wheel_view.tween_update_energy_bar(energy_count)

func _reset_arm_rotation():
	arm.rotation_degrees = 31

func _tween_reset_arm_rotation():
	var tween : Tween = create_tween()
	tween.tween_property(arm,"rotation_degrees",31,0.1)
	await tween.finished
	tween.kill()

func _tween_shoot():
	var new_scale := Vector2(1.3,1.0)
	var tween : Tween = create_tween()
	tween.tween_property(arm,"scale",new_scale,0.1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(arm,"scale",Vector2.ONE,0.1).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
