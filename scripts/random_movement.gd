extends Node
class_name RandomMovement
@export var targets : Array[Node2D]
@export var min_distance : float = 100
@export var max_distance : float = 500
@export var cooldown : float = 1.0
@onready var timer: Timer = $Timer

func _ready() -> void:
	_tween_distance()
	timer.start(cooldown)
	timer.timeout.connect(_tween_distance)

func _tween_distance():
	for target in targets:
		var tween : Tween = create_tween()
		var new_position := target.global_position + Vector2(
			randf_range(max_distance,min_distance),
			randf_range(min_distance,max_distance) *-1)
		tween.tween_property(target,"global_position", new_position,2.0)
		await tween.finished
		tween.kill()
	
