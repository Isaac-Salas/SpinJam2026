extends Node
class_name FollowTarget
@export var speed : float = 100
@export var move_node: Node2D
@export var target_node : Node2D
@export var follow_x: bool
@export var follow_y : bool


func _physics_process(delta: float) -> void:
	if move_node and target_node:
		var direction = move_node.global_position.direction_to(target_node.global_position)
		var new_position = direction* speed * delta
		if follow_x:
			move_node.global_position.x += new_position.x
		if follow_y:
			move_node.global_position.y += new_position.y
		
