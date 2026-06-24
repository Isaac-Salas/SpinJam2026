extends Area2D
class_name AreaPlayerWin
@export var level : Level

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body : Node2D):
	if body is Player:
		level.win()
