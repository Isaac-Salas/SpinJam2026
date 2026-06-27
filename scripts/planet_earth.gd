extends Node2D
class_name PlanetEarth
@onready var grapple_killer: GrappleKiller = $GrappleKiller
@onready var extinguish_killer: ExtinguishKiller = $ExtinguishKiller

func _ready() -> void:
	grapple_killer.area_entered.connect(_on_enter_areas)
	extinguish_killer.area_entered.connect(_on_enter_areas)

func _on_enter_areas(area : Area2D):
	if area is Extinguishable or area is Hookable:
		_tween_scale_hurt()


func _tween_scale_hurt():
	var reset := Vector2.ONE
	var tween : Tween = create_tween()
	tween.tween_property(self,"scale",reset*1.5, 0.1)
	tween.tween_property(self,"scale",reset, 0.1)
	await tween.finished
	tween.kill()
