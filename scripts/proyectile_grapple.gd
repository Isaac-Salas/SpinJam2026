extends Area2D
class_name ProyectileGrapple
@export var start_detecting : bool
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D



func _ready() -> void:
	toggle_detection(start_detecting)


func toggle_detection(value : bool):
	self.set_deferred("monitoring",value)
	self.set_deferred("monitorable",value)
