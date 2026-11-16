extends Node
var current_level : int = 0
var use_system : bool = true

func _init() -> void:
	if use_system:
		load_level()
		OverlayUI.current_scene_number = current_level

func update_current_level(value : int):
	current_level = value

func save_level():
	var file = FileAccess.open("user://data.save", FileAccess.WRITE)
	var save_dict := {"current_level" : current_level}
	if file:
		file.store_var(save_dict)
		file.close()  

func load_level():
	if not FileAccess.file_exists("user://data.save"):
		return
	var save_file = FileAccess.open("user://data.save", FileAccess.READ)
	var save : Dictionary = save_file.get_var()
	#print(save)
	var keys : Array = save.keys()
	var values: Array = save.values()
	set(keys[0],values[0])
	print(current_level)
