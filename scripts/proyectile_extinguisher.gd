extends Node2D
class_name ProyectileShoot
@export var start_detecting : bool
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	toggle_detection(start_detecting)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	kill()

func kill():
	toggle_detection(false)
	sprite_2d.visible = false
	gpu_particles_2d.emitting = true
	await gpu_particles_2d.finished
	self.queue_free()

func toggle_detection(value : bool):
	area_2d.monitoring = value
	area_2d.monitorable = value
