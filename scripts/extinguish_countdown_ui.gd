extends Label
@export var tracker : ExtinguishTracker
var time_left_int : int :
	set(value):
		if value != time_left_int:
			time_left_int = value



func _process(_delta: float) -> void:
	if tracker:
		time_left_int = int(tracker.limit_timer.time_left) 
		self.text = "Time left: "+ str(time_left_int + 1)
	else:
		self.text = "DONE!"
