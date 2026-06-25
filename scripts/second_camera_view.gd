extends Control
class_name SecondView
@onready var tracking_cam: TrackingCam = $SubViewportContainer/SubViewport/Tracking_cam

func toggle_show_view(value : bool):
	print(value)
	self.visible = value
