extends Node
@export var target : Node2D
@export var speed : float = 50
@export var move : bool = true




func _physics_process(delta: float) -> void:
	if target and move:
		target.global_position.y -= speed*delta
		
func toggle_move(value : bool):
	move = value
	
