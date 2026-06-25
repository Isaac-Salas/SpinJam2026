extends Area2D
class_name Extinguishable
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var timer: Timer = $"../Timer"

signal tween_fire_finish

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	_tween_fire()
	tween_fire_finish.connect(_tween_fire)


func _on_area_entered(area : Area2D):
	if area is ProyectileArea:
		_kill()

func _kill():
	toggle_detection(false)
	sprite_2d.visible = false
	gpu_particles_2d.emitting = true
	await _snuff_fire_out()
	await gpu_particles_2d.finished
	
	self.queue_free()

func toggle_detection(value : bool):
	self.set_deferred("monitoring",value)
	self.set_deferred("monitorable",value)

func _snuff_fire_out():
	tween_fire_finish.disconnect(_tween_fire)
	var tween : Tween = create_tween()
	tween.tween_property(point_light_2d,"energy",0.0,0.8)
	await tween.finished
	tween.kill()

func _tween_fire():
	var random_value : float = randf_range(1.0,2.0)
	var tween : Tween = create_tween()
	tween.tween_property(point_light_2d,"energy",random_value,0.1)
	await tween.finished
	tween.kill()
	tween_fire_finish.emit()
