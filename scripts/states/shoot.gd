extends State
class_name Shoot
@export var crosshair : Crosshair
@export var aim_interpolation_mult : float = 10
var current_target_number : int = 1

var arm : ArmExtinguisher

func Enter():
	arm = player.body_parts.arm_lshoot
	_reset_arm_rotation()
	OverlayUI.wheel_view.rotator.rotation_count_changed.connect(start_shooting)
	arm.visible = true
	player.body_parts.arm_l.visible = false

func Update(_delta: float):
	var current_target : Node2D = crosshair.get("_"+str(current_target_number))
	var target_angle = atan2(current_target.global_position.y - arm.global_position.y, 
	current_target.global_position.x - arm.global_position.x)
	arm.global_rotation = lerp_angle(arm.global_rotation,target_angle,_delta*5)
	

func Exit():
	OverlayUI.wheel_view.rotator.rotation_count_changed.disconnect(start_shooting)
	await _tween_reset_arm_rotation()
	arm.visible = false
	player.body_parts.arm_l.visible = true

func start_shooting(looking_at : int):
	if looking_at != 0:
		if looking_at <= 3 and looking_at > 0:
			current_target_number = looking_at
		elif looking_at > 3:
			current_target_number = 3
		_tween_shoot()
		arm.particles.emitting = true
		var new_target : Node2D = crosshair.get("_"+str(current_target_number))
		arm.shoot(new_target.global_position)
	else:
		current_target_number = 1
		arm.particles.emitting = false

func _reset_arm_rotation():
	arm.rotation_degrees = 125

func _tween_reset_arm_rotation():
	var tween : Tween = create_tween()
	tween.tween_property(arm,"rotation_degrees",125,0.1)
	await tween.finished
	tween.kill()

func _tween_shoot():
	var hose = arm.ext_manguera
	var new_scale := Vector2(1.3,1.0)
	var tween : Tween = create_tween()
	tween.tween_property(hose,"scale",new_scale,0.1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(hose,"scale",Vector2.ONE,0.1).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
