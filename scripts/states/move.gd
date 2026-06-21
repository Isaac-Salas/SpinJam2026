extends State
class_name MoveState

func Enter():
	OverlayUI.wheel_view.rotator.rotation_side_change.connect(_flip_sides)

func Exit():
	OverlayUI.wheel_view.rotator.rotation_side_change.disconnect(_flip_sides)


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
