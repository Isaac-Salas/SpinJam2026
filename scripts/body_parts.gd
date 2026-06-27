extends Node2D
class_name PlayerBodyParts
@export var stumpy_mode : bool
@onready var arm_r: Sprite2D = $ArmRBone
@onready var leg_r: Sprite2D = $LegRBone
@onready var leg_l: Sprite2D = $LegLBone
@onready var torso: Sprite2D = $TorsoBone
@onready var small_torso: Sprite2D = $TorsoBone/SmallTorso
@onready var normal_torso: Sprite2D = $TorsoBone/NormalTorso
@onready var arm_l: Sprite2D = $ArmLBone
@onready var head: Sprite2D = $HeadBone
@onready var arm_lshoot: ArmExtinguisher = $ArmLshoot
@onready var arm_r_grapple: ArmGrapple = $ArmRGrapple
@onready var propulsor_l: Sprite2D = $LegLBone/Propulsor
@onready var propulsor_r: Sprite2D = $LegRBone/Propulsor
@onready var p_rocket_r: GPUParticles2D = $LegRBone/Propulsor/GPUParticles2D
@onready var p_rocket_l: GPUParticles2D = $LegLBone/Propulsor/GPUParticles2D


func _ready() -> void:
	_toggle_stumpy_mode(stumpy_mode)
	OverlayUI.wheel_view.state_button_pressed.connect(_tween_scale)

func toggle_rocket_particles(value : bool):
	p_rocket_l.emitting = value
	p_rocket_r.emitting = value

func _tween_scale():
	var original_direction = sign(self.scale.x)
	var reset_scale := Vector2(original_direction,1.0)
	var tween : Tween = create_tween()
	tween.tween_property(self,"scale",reset_scale*1.2,0.1)
	tween.tween_property(self,"scale",reset_scale,0.1)
	await tween.finished
	tween.kill()

func _toggle_stumpy_mode(value : bool):
	arm_r.visible = not value
	arm_l.visible = not value
	head.visible = not value
	normal_torso.visible = not value
	small_torso.visible = value
