extends Node
class_name LastBossSpawners
@onready var cooldown_timer: Timer = $CooldownTimer
@export var spawn_manager : SpawnManager
@export var level : Level
var scambled_numbers : Array
const METEORITE = preload("uid://cdqo13mq4nc2v")
const FIREBALL = preload("uid://22s16nwsu7bx")
var both_objects : Array[PackedScene] = [METEORITE,FIREBALL]
var lost : bool


func _ready() -> void:
	level.music_started.connect(_initialize_manager)

func _initialize_manager():
	spawn_manager._get_spawners_and_connect()
	spawn_manager.object_despawned.connect(_on_object_despawned)
	spawn_manager.object_spawned.connect(_on_object_spawned)
	scambled_numbers = get_shuffled_range(0,spawn_manager.all_spawners.size())
	cooldown_timer.timeout.connect(_on_cooldown_timeout)
	_spawn_random_object()


func _spawn_random_object():
	var random_to_spawn : PackedScene = both_objects.pick_random()
	var pick_number: int = scambled_numbers.pick_random()
	spawn_manager.all_spawners[pick_number].spawn(random_to_spawn)

func get_shuffled_range(from: int, to: int) -> Array:
	var numbers = []
	for i in range(from, to):
		numbers.append(i)
	numbers.shuffle()
	print(numbers)
	return numbers

func _on_object_despawned(_object : Node2D):
	if not lost:
		cooldown_timer.start(randf_range(3,5))

func _on_object_spawned(object : Node2D):
	if object is Hookable or object is Extinguishable:
		object.killed_by_killer.connect(_on_object_killed_by_killer)

func _on_object_killed_by_killer():
	level.lose()
	lost = true
	_clear_self_and_spawner()

func _on_cooldown_timeout():
	_spawn_random_object()

func _clear_self_and_spawner():
	spawn_manager.queue_free()
	self.queue_free()
