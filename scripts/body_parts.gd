extends Node2D
class_name PlayerBodyParts
@export var stumpy_mode : bool
@onready var arm_r: Sprite2D = $ArmR
@onready var leg_r: Sprite2D = $LegR
@onready var leg_l: Sprite2D = $LegL
@onready var torso: Sprite2D = $Torso
@onready var small_torso: Sprite2D = $Torso/SmallTorso
@onready var normal_torso: Sprite2D = $Torso/NormalTorso
@onready var arm_l: Sprite2D = $ArmL
@onready var head: Sprite2D = $Head
@onready var arm_lshoot: ArmExtinguisher = $ArmLshoot
@onready var arm_r_grapple: ArmGrapple = $ArmRGrapple
@onready var propulsor_l: Sprite2D = $LegL/Propulsor
@onready var propulsor_r: Sprite2D = $LegR/Propulsor
@onready var p_rocket_r: GPUParticles2D = $LegR/Propulsor/GPUParticles2D
@onready var p_rocket_l: GPUParticles2D = $LegL/Propulsor/GPUParticles2D

var original_scale : Vector2

func _ready() -> void:
	_toggle_stumpy_mode(stumpy_mode)
	original_scale = self.scale
	OverlayUI.wheel_view.state_button_pressed.connect(_tween_scale)

func toggle_rocket_particles(value : bool):
	p_rocket_l.emitting = value
	p_rocket_r.emitting = value

func _tween_scale():
	var tween : Tween = create_tween()
	tween.tween_property(self,"scale",self.scale*1.1,0.1)
	tween.tween_property(self,"scale",original_scale,0.1)
	await tween.finished
	tween.kill()

func _toggle_stumpy_mode(value : bool):
	arm_r.visible = not value
	arm_l.visible = not value
	head.visible = not value
	normal_torso.visible = not value
	small_torso.visible = value
