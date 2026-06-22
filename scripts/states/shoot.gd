extends State
class_name Shoot
@export var crosshair : Crosshair
var current_target_number : int = 1

func Enter():
	OverlayUI.wheel_view.rotator.rotation_count_changed.connect(start_shooting)
	player.body_parts.arm_lshoot.visible = true
	player.body_parts.arm_l.visible = false

func  Update(_delta: float):
	player.body_parts.arm_lshoot.look_at(crosshair.get("_"+str(current_target_number)).global_position)

func Exit():
	player.body_parts.arm_lshoot.visible = false
	player.body_parts.arm_l.visible = true

func start_shooting(looking_at : int):
	if looking_at != 0:
		if looking_at <= 3 and looking_at > 0:
			current_target_number = looking_at
		elif looking_at > 3:
			current_target_number = 3
		player.body_parts.arm_lshoot.particles.emitting = true
		var new_target : Node2D = crosshair.get("_"+str(current_target_number))
		player.body_parts.arm_lshoot.shoot(new_target.global_position)
	else:
		current_target_number = 1
		player.body_parts.arm_lshoot.particles.emitting = false
