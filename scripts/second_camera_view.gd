extends Control
class_name SecondView
@export var world_root : Node2D
@onready var tracking_cam: TrackingCam = $SubViewportContainer/SubViewport/Tracking_cam
@onready var viewport: SettableViewPort = $SubViewportContainer/SubViewport


func toggle_show_view(value : bool):
	print(value)
	self.visible = value

func set_target(target : Node2D):
	tracking_cam.target_follow = target
