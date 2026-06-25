extends CharacterBody2D
class_name Player
@export var use_gavity : bool = true
@export var gravity_multiplier : float = 0.1
@export var crosshair_offset_x : float = 0.0
@onready var body_parts: PlayerBodyParts = $BodyParts
@onready var hook: Sprite2D = $BodyParts/ArmRBone/Hook
@onready var propulsorR: Sprite2D = $BodyParts/LegRBone/Propulsor
@onready var propulsorL: Sprite2D = $BodyParts/LegLBone/Propulsor
@onready var ext_tanque: Sprite2D = $BodyParts/ArmLBone/ExtTanque
@onready var ext_manguera: Sprite2D = $BodyParts/ArmLBone/ExtManguera
@onready var mira: Sprite2D = $BodyParts/HeadBone/Mira
@onready var crosshair: Crosshair = $Crosshair
@onready var state_machine: PlayerStateMachine = $PlayerStateMachine
@export_category("Unlocked_skills")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animation_player: AnimationPlayer = $BodyParts/AnimationPlayer


func _ready() -> void:
	update_unlocks()
	crosshair.position.x += crosshair_offset_x

func _physics_process(delta: float) -> void:
	if use_gavity:
		if not is_on_floor():
			velocity += (get_gravity()*gravity_multiplier )* delta
	move_and_slide()

func update_unlocks():
	ext_tanque.visible = OverlayUI.wheel_view.player_shoot
	ext_manguera.visible = OverlayUI.wheel_view.player_shoot
	#crosshair.visible = OverlayUI.wheel_view.player_aim
	mira.visible = OverlayUI.wheel_view.player_aim
	propulsorL.visible = OverlayUI.wheel_view.player_fly
	propulsorR.visible = OverlayUI.wheel_view.player_fly
	hook.visible = OverlayUI.wheel_view.player_grapple
