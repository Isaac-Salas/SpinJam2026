extends SubViewport
@export var world_root : Node2D
func _ready() -> void:
	world_2d = world_root.get_viewport().world_2d
