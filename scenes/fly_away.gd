extends Node
@export var target : Node2D
@export var speed : float = 50


func _physics_process(delta: float) -> void:
	if target:
		target.global_position.y -= speed*delta
