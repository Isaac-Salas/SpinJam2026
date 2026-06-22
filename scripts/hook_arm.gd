extends Node2D
class_name ArmGrapple
@onready var arm_r: Sprite2D = $ArmR
@onready var hook: Sprite2D = $ArmR/Hook
@onready var shoot_from_here: Marker2D = $ShootFromHere
@onready var particles: GPUParticles2D = $ShootFromHere/Particles


@export var proyectile : Proyectile

func shoot(target_position : Vector2):
	var new_proyectile : Proyectile = proyectile.duplicate()
	shoot_from_here.add_child(new_proyectile)
	new_proyectile.visible = true
	new_proyectile.toggle_detection(true)
	new_proyectile.global_position = shoot_from_here.global_position
	var tween : Tween = create_tween()
	tween.tween_property(new_proyectile,"global_position",target_position,0.5)
	await tween.finished
	new_proyectile.kill()
	tween.kill()
