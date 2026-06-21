extends State
class_name Aim
@export var crosshair : Crosshair

func Update(_delta: float):
	if OverlayUI.wheel_view.rotator.wheel_spinning:
		var wheel_rotation = OverlayUI.wheel_view.rotator.wheel.global_rotation
		crosshair.rotation = lerp_angle(crosshair.rotation,wheel_rotation,_delta * 10)
