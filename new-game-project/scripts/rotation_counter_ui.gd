extends Label
@export var wheel : SpinningWheel

func _ready() -> void:
	wheel.rotation_count_changed.connect(_update_count)

func _update_count(value : int):
	self.text = str(value)
