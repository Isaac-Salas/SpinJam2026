extends Node2D
class_name ProyectileGrapple
@export var start_detecting : bool
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	toggle_detection(start_detecting)

func toggle_detection(value : bool):
	area_2d.monitoring = value
	area_2d.monitorable = value
