extends Node
@export var level : Level
@onready var corazon: TextureRect = $"../CanvasLayer/Control/Corazon"
@export var luz: TextureRect
var original_scale : Vector2
var original_light : Color
@onready var timer: Timer = $"../Timer"


func _ready() -> void:
	original_scale = corazon.offset_transform_scale
	original_light = luz.modulate
	timer.timeout.connect(_tween_heart)
	OverlayUI.wheel_view.rotator.rotation_count_changed.connect(_turn_counter)
	

func _turn_counter(count : int):
	_tween_heart()
	if count == 3:
		level.win()
		timer.start()



func _tween_heart():
	var tween : Tween = create_tween()
	var color_tween : Tween = create_tween()
	var new_scale = original_scale*1.3
	var new_color := Color(original_light,0.6)
	tween.tween_property(corazon,"offset_transform_scale",new_scale,0.1)
	tween.tween_property(corazon,"offset_transform_scale",original_scale,0.1)
	color_tween.tween_property(luz,"modulate",new_color,0.1)
	color_tween.tween_property(luz,"modulate",original_light,0.1)
	await tween.finished
	await color_tween.finished
	tween.kill()
	color_tween.kill()
