extends State
class_name Move
@export var fixed_speed : float = 100.0
var running_speed_multiplier : int

func Enter():
	OverlayUI.wheel_view.rotator.rotation_side_change.connect(_flip_sides)
	OverlayUI.wheel_view.rotator.rotation_count_changed.connect(_on_count_changed)

func Exit():
	OverlayUI.wheel_view.rotator.rotation_side_change.disconnect(_flip_sides)
	OverlayUI.wheel_view.rotator.rotation_count_changed.disconnect(_on_count_changed)

func Update(_delta: float):
	player.velocity.x = fixed_speed * running_speed_multiplier

func _on_count_changed(value : int):
	running_speed_multiplier = value
	if running_speed_multiplier != 0:
		player.animation_player.play("run",0.1,running_speed_multiplier)
	else:
		player.animation_player.play("Idle")

func _flip_sides(side : String):
	if side != "":
		var new_scale_x : float
		if side == "left":
			new_scale_x = -1.0
		elif side == "right":
			new_scale_x = 1.0
		var new_scale := Vector2(new_scale_x,1.0)
		var tween : Tween = create_tween()
		tween.tween_property(player.body_parts,"scale",new_scale,0.2)
		#tween.tween_property(player.crosshair,"scale",new_scale,0.2)
		await tween.finished
		tween.kill()
