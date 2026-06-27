extends Sprite2D
@onready var progress_bar: TextureProgressBar = $SubViewport/Control/ProgressBar
@export var max_health : int = 5
@export var boss : Robot
@export var level : Level
@export var boss_spawner : LastBossSpawners
@export var hitbox : Area2D
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var gpu_particles_2d: GPUParticles2D = $"../GPUParticles2D"

var current_health : int
var initial_boss_scale : Vector2
signal no_more_health

func _ready() -> void:
	initial_boss_scale = boss.scale
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
	animation_player.play("lose_shake")
	gpu_particles_2d.emitting = true
	self.visible = false
	if boss_spawner:
		boss_spawner._clear_self_and_spawner()

func _on_hitbox_area_entered(area : Area2D):
	if area is ProyectileGrapple or area is ProyectileArea:
		_hurt()
		_tween_scale_hurt()

func _tween_scale_hurt():
	var tween : Tween = create_tween()
	tween.tween_property(boss,"scale",initial_boss_scale *1.5, 0.05)
	tween.tween_property(boss,"scale",initial_boss_scale, 0.05)
	await tween.finished
	tween.kill()
