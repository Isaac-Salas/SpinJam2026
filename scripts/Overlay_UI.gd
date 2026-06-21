extends Control
@onready var game_view: SubViewportContainer = $Gameview
@onready var sub_viewport: SubViewport = $Gameview/SubViewport

@onready var wheel_view: WheelControl = $WheelView
@export var scene_array : Array[PackedScene]
@export var current_scene : int = 0

func _ready() -> void:
	go_to_scene(current_scene)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		reload_scene()

func go_to_scene(scene_num : int):
	clean_scene()
	var new_scene_instance = scene_array[scene_num].instantiate()
	sub_viewport.add_child(new_scene_instance)
	current_scene = scene_num

func go_to_next_scene():
	clean_scene()
	var new_scene_number = current_scene + 1
	var new_scene_instance = scene_array[new_scene_number].instantiate()
	sub_viewport.add_child(new_scene_instance)
	current_scene = new_scene_number

func reload_scene():
	go_to_scene(current_scene)

func clean_scene():
	for child in sub_viewport.get_children():
		child.queue_free()
