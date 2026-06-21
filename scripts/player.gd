extends CharacterBody2D
class_name Player
@onready var body_parts: Node2D = $BodyParts

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animation_player: AnimationPlayer = $BodyParts/AnimationPlayer


func _physics_process(delta: float) -> void:
	move_and_slide()
