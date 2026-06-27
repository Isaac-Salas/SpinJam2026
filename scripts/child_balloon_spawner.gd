extends Node2D
@export var spawn_manager : SpawnManager
@onready var sprite: Sprite2D = $"../Sprite"
@onready var balloon: Sprite2D = $"../Balloon"
@onready var spawner: Spawner = $".."


func _ready() -> void:
	spawner.spawned.connect(_on_spawner_spawned)

func _on_spawner_spawned(_object : Node2D):
	_hide_balloon()

func _hide_balloon():
	balloon.visible = false
