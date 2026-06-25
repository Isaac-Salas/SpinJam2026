extends Area2D
class_name AreaPlayerWin
@export var level : Level
@export var lose_on_robot : bool

func _ready() -> void:
	toggle_detection(true)
	body_entered.connect(_on_body_entered)
	if lose_on_robot:
		area_entered.connect(_on_area_entered)

func _on_body_entered(body : Node2D):
	if body is Player:
		level.win()
		toggle_detection(false)

func _on_area_entered(area : Area2D):
	if area is RobotLoseArea:
		level.lose()
		toggle_detection(false)

func toggle_detection(value : bool):
	self.set_deferred("monitoring",value)
	self.set_deferred("monitorable",value)
