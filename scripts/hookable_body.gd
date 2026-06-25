extends Area2D
class_name Hookable
@onready var sprite: Sprite2D = $Sprite
@export var active : bool = true
@export var player : Player
var target 

func _ready() -> void:
	toggle_detection(active)
	area_entered.connect(_on_area_entered)


func _on_area_entered(area : Area2D):
	if area is ProyectileGrapple:
		_finish(area)

func _finish(target_parent : Node2D):
	toggle_detection(false)
	call_deferred("reparent",target_parent)
	var random_offset := Vector2(randf_range(10,50),randf_range(10,50))
	var random_rotation_degrees : float = randf_range(1,360)
	global_position = target_parent.global_position + random_offset
	global_rotation_degrees = random_rotation_degrees
	await _tween_disappear()
	self.queue_free()

func toggle_detection(value : bool):
	self.set_deferred("monitoring",value)
	self.set_deferred("monitorable",value)
	active = value

func _tween_disappear():
	var tween : Tween = create_tween()
	tween.tween_property(self,"modulate",Color(0.0, 0.0, 0.0, 0.0),1.0)
	await tween.finished
	tween.kill()
