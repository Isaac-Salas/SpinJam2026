extends Node
class_name RobotSecondViewToggler
@export var toggle_treshold : float = 800
@export var second_view : SecondView
@export var robot : RobotPathFollower
var toggle : bool:
	set(value):
		if value != toggle:
			toggle = value
			_toggle_second_view(toggle)

func _ready() -> void:
	robot.distance_to_player_changed.connect(_on_distance_to_player_change)

func _on_distance_to_player_change(value : float):
	if value > toggle_treshold:
		toggle = true
	else:
		toggle = false

func _toggle_second_view(value : bool):
	second_view.toggle_show_view(value)
