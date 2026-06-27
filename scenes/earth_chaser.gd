extends Node
@export var target : Node2D
@export var speed : float = 100
var earth : PlanetEarth

func _ready() -> void:
	_find_earth()

func _physics_process(delta: float) -> void:
	if earth:
		print(earth)
		_chase_earth(delta)

func _chase_earth(delta : float):
	var direction = target.global_position.direction_to(earth.global_position)
	target.global_position +=  direction * speed* delta

func _find_earth():
	var current_scene_children : Array = OverlayUI.current_scene.get_children()
	for child in current_scene_children:
		if child is PlanetEarth:
			earth = child
