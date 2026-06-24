extends Node

@export var target_robot: Robot
@export_group("Animate on points")
@export var path_follower : RobotPathFollower
@export var point_and_animation : Dictionary[int, String]

func _ready() -> void:
	if path_follower:
		path_follower.current_point_changed.connect(_animate_for_point)

func _animate_for_point(current_point : int):
	var function_name = point_and_animation.get(current_point)
	if function_name != null:
		self.call(function_name)

func jump_walk():
	_jump_scale_tween()
	target_robot.animation_player.play("jump")
	await target_robot.animation_player.animation_finished
	target_robot.animation_player.play("run",0.2)

func jump_idle():
	_jump_scale_tween()
	target_robot.animation_player.play("jump")
	await target_robot.animation_player.animation_finished
	target_robot.animation_player.play("Idle",0.2)

func walk():
	target_robot.animation_player.play("run",0.2)

func _jump_scale_tween():
	var tween : Tween = create_tween()
	var original_scale : Vector2 = target_robot.scale
	var new_scale := Vector2(target_robot.scale.x,target_robot.scale.y + .3)
	tween.tween_property(target_robot,"scale",new_scale,0.1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(target_robot,"scale",original_scale,0.1).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
	tween.kill()
