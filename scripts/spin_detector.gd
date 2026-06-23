extends Node
@export var level : Level

func _ready() -> void:
	OverlayUI.wheel_view.rotator.rotation_count_changed.connect(_turn_counter)
	

func _turn_counter(count : int):
	if count == 3:
		level.win()
