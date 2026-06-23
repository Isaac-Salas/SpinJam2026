extends Control
@onready var game_view: SubViewportContainer = $Gameview
@onready var sub_viewport: SubViewport = $Gameview/SubViewport

@onready var wheel_view: WheelControl = $WheelView
@export var current_scene_number : int = 0
@export var scene_array : Array[PackedScene]
var current_scene : Level
@onready var transitions: TransitionManager = $Transitions



func _ready() -> void:
	go_to_scene(current_scene_number)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		reload_scene()

func go_to_scene(scene_num : int):
	clean_scene()
	var new_scene_instance : Level = scene_array[scene_num].instantiate()
	sub_viewport.add_child(new_scene_instance)
	current_scene_number = scene_num
	current_scene = new_scene_instance

func go_to_next_scene():
	clean_scene()
	var new_scene_number = current_scene_number + 1
	var new_scene_instance : Level = scene_array[new_scene_number].instantiate()
	sub_viewport.add_child(new_scene_instance)
	current_scene_number = new_scene_number
	current_scene = new_scene_instance

func reload_scene():
	go_to_scene(current_scene_number)

func clean_scene():
	for child in sub_viewport.get_children():
		child.queue_free()
