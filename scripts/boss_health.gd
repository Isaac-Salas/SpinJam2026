extends Sprite2D
@onready var progress_bar: TextureProgressBar = $SubViewport/Control/ProgressBar
@export var max_health : int = 5
@export var level : Level
@export var boss_spawner : LastBossSpawners
@export var hitbox : Area2D
var current_health : int
signal no_more_health

func _ready() -> void:
	_init_health()
	_initilize_hitbox()

func _init_health():
	progress_bar.max_value = max_health
	current_health = max_health
	progress_bar.value = current_health
	no_more_health.connect(_on_no_more_health)

func _initilize_hitbox():
	hitbox.area_entered.connect(_on_hitbox_area_entered)

func _hurt():
	current_health -= 1
	progress_bar.value = current_health
	if current_health <= 0:
		no_more_health.emit()

func _on_no_more_health():
	level.win()
	if boss_spawner:
		boss_spawner._clear_self_and_spawner()

func _on_hitbox_area_entered(area : Area2D):
	if area is ProyectileGrapple or area is ProyectileArea:
		_hurt()
