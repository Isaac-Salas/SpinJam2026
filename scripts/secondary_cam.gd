extends SubViewport
class_name SettableViewPort
@onready var second_view: SecondView = $"../.."

func _ready() -> void:
	world_2d = second_view.world_root.get_viewport().world_2d
