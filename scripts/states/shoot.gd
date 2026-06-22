extends State
class_name Shoot
@export var crosshair : Crosshair
@export var aim_interpolation_mult : float = 10
var current_target_number : int = 1
var shooting : bool:
	set(value):
		if value != shooting:
			shooting = value
			shooting_changed.emit(value)

signal shooting_changed(value : bool)

var arm : ArmExtinguisher

func Enter():
	arm = player.body_parts.arm_lshoot
	_reset_arm_rotation()
	OverlayUI.wheel_view.rotator.rotation_count_changed.connect(start_shooting)
	player.body_parts.arm_lshoot.visible = true
	player.body_parts.arm_l.visible = false

func Update(_delta: float):
	var current_target : Node2D = crosshair.get("_"+str(current_target_number))
	var target_angle = atan2(current_target.global_position.y - arm.global_position.y, 
	current_target.global_position.x - arm.global_position.x)
	arm.rotation = lerp_angle(arm.rotation,target_angle,_delta*5)
	

func Exit():
	OverlayUI.wheel_view.rotator.rotation_count_changed.disconnect(start_shooting)
	await _tween_reset_arm_rotation()
	player.body_parts.arm_lshoot.visible = false
	player.body_parts.arm_l.visible = true

func start_shooting(looking_at : int):
	if looking_at != 0:
		if looking_at <= 3 and looking_at > 0:
			current_target_number = looking_at
		elif looking_at > 3:
			current_target_number = 3
		shooting = true
		player.body_parts.arm_lshoot.particles.emitting = true
		var new_target : Node2D = crosshair.get("_"+str(current_target_number))
		player.body_parts.arm_lshoot.shoot(new_target.global_position)
	else:
		shooting = false
		current_target_number = 1
		player.body_parts.arm_lshoot.particles.emitting = false

func _reset_arm_rotation():
	arm.rotation_degrees = 125

func _tween_reset_arm_rotation():
	var tween : Tween = create_tween()
	tween.tween_property(arm,"rotation_degrees",125,0.1)
	await tween.finished
	tween.kill()
