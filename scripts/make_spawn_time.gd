extends Node
@export var spawn_manager : SpawnManager
@export var despawns_to_win : int = 3
@export var can_repeat_spawner : bool = true
@export var second_view : SecondView
@export var level : Level
var scambled_numbers : Array

func _ready() -> void:
	level.music_started.connect(_initialize_manager)

func _initialize_manager():
	spawn_manager._get_spawners_and_connect()
	spawn_manager.object_despawned.connect(_on_object_despawned)
	spawn_manager.object_spawned.connect(_on_object_spawned)
	scambled_numbers = get_shuffled_range(0,spawn_manager.all_spawners.size())
	print(spawn_manager.all_spawners)
	_spawn_object()

func _update_count():
	despawns_to_win -= 1
	print(despawns_to_win)
	if despawns_to_win <= 0:
		level.win()
		self.queue_free()

func _spawn_object():
	var pick_number: int = scambled_numbers.pick_random()
	spawn_manager.all_spawners[pick_number].spawn()
	if not can_repeat_spawner:
		scambled_numbers.erase(pick_number)

func get_shuffled_range(from: int, to: int) -> Array:
	var numbers = []
	for i in range(from, to):
		numbers.append(i)
	numbers.shuffle()
	print(numbers)
	return numbers

func _on_object_despawned(_object : Node2D):
	_update_count()
	if despawns_to_win != 0:
		_spawn_object()

func _on_object_spawned(object : Node2D):
	second_view.set_target(object)
	if object is Hookable:
		object.killed_by_killer.connect(_on_object_killed_by_killer)

func _on_object_killed_by_killer():
	self.queue_free()
	level.lose()
	print("Teamuch Paum")
	
