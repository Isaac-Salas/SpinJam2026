extends Label
@export var wheel : SpinningWheel

func _ready() -> void:
	wheel.rotation_count_changed.connect(_update_count)

func _update_count(value : int):
	self.text = str(value)
	_tween_counter()

func _tween_counter():
	var tween : Tween = create_tween()
	tween.tween_property(self,"offset_transform_scale",Vector2.ONE*1.5,0.1)
	tween.tween_property(self,"offset_transform_scale",Vector2.ONE,0.1)
	await tween.finished
	tween.kill()
