extends Node2D
class_name ArmGrapple
@onready var arm_r: Sprite2D = $ArmR
@onready var shoot_from_here: Marker2D = $ShootFromHere
@onready var particles: GPUParticles2D = $ShootFromHere/Particles
@onready var line_2d: Line2D = $Line2D

@export var proyectile : ProyectileGrapple
var initial_proyectile_position : Vector2

func _ready() -> void:
	if proyectile:
		initial_proyectile_position = proyectile.position

func _process(delta: float) -> void:
	line_2d.set_point_position(0,to_local(shoot_from_here.global_position))
	line_2d.set_point_position(1,to_local(proyectile.global_position))

func shoot(target_position : Vector2):
	proyectile.toggle_detection(true)
	var tween : Tween = create_tween()
	tween.tween_property(proyectile,"global_position",target_position,0.25)
	tween.tween_property(proyectile,"position",initial_proyectile_position,0.25)
	await tween.finished
	proyectile.toggle_detection(false)
	tween.kill()
