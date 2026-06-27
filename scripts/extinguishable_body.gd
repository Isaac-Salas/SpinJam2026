extends Area2D
class_name Extinguishable
@export var active : bool = true
@onready var wood: Sprite2D = $Wood
@onready var fire: Sprite2D = $Fire
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var point_light_2d: PointLight2D = $PointLight2D

signal tween_fire_finish
signal active_changed()
signal killed_by_player
signal killed_by_killer

func _ready() -> void:
	toggle_detection(active)
	area_entered.connect(_on_area_entered)
	_tween_fire()
	tween_fire_finish.connect(_tween_fire)


func _on_area_entered(area : Area2D):
	if area is ProyectileArea:
		await _kill()
		killed_by_player.emit()
	elif area is ExtinguishKiller:
		await _kill()
		killed_by_killer.emit()

func _kill():
	toggle_detection(false)
	_tween_scale_wood()
	fire.visible = false
	gpu_particles_2d.emitting = true
	await _snuff_fire_out()
	await gpu_particles_2d.finished
	self.queue_free()
	

func toggle_detection(value : bool):
	self.set_deferred("monitoring",value)
	self.set_deferred("monitorable",value)
	active = value
	active_changed.emit()

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

func _tween_scale_wood():
	var original_scale = wood.scale
	var tween : Tween = create_tween()
	tween.tween_property(wood,"scale",original_scale * 1.5,0.1)
	tween.tween_property(wood,"scale",original_scale,0.1)
	await tween.finished
	wood.visible = false
	tween.kill()

func toggle_visibility(value : bool):
	self.visible = value
