extends Node2D
class_name ArmGrapple
@onready var arm_r: Sprite2D = $ArmR
@onready var hook: Sprite2D = $ArmR/Hook
@onready var shoot_from_here: Marker2D = $ShootFromHere
@onready var particles: GPUParticles2D = $ShootFromHere/Particles

@export var proyectile : ProyectileGrapple
var initial_proyectile_position : Vector2

func _ready() -> void:
	if proyectile:
		initial_proyectile_position = proyectile.position

func shoot(target_position : Vector2):
	#var new_proyectile : ProyectileGrapple = proyectile.duplicate()
	#shoot_from_here.add_child(new_proyectile)
	#new_proyectile.visible = true
	#new_proyectile.toggle_detection(true)
	#new_proyectile.global_position = shoot_from_here.global_position
	var tween : Tween = create_tween()
	tween.tween_property(proyectile,"global_position",target_position,0.25)
	tween.tween_property(proyectile,"position",initial_proyectile_position,0.25)
	await tween.finished
	tween.kill()
