extends Node2D
class_name PlayerBodyParts
@onready var arm_r: Sprite2D = $ArmR
@onready var leg_r: Sprite2D = $LegR
@onready var leg_l: Sprite2D = $LegL
@onready var torso: Sprite2D = $Torso
@onready var arm_l: Sprite2D = $ArmL
@onready var head: Sprite2D = $Head
@onready var arm_lshoot: ArmExtinguisher = $ArmLshoot
@onready var arm_r_grapple: ArmGrapple = $ArmRGrapple
@onready var propulsor_l: Sprite2D = $LegL/Propulsor
@onready var propulsor_r: Sprite2D = $LegR/Propulsor
@onready var p_rocket_r: GPUParticles2D = $LegR/Propulsor/GPUParticles2D
@onready var p_rocket_l: GPUParticles2D = $LegL/Propulsor/GPUParticles2D


func toggle_rocket_particles(value : bool):
	p_rocket_l.emitting = value
	p_rocket_r.emitting = value
