extends State
class_name Fly
@export var fixed_fly_speed : float = 100
var flying_speed_multiplier : int


func Enter():
	player.use_gavity = false
	player.body_parts.toggle_rocket_particles(true)
	OverlayUI.wheel_view.rotator.rotation_count_changed.connect(_on_count_changed)
	player.animation_player.play("fly",0.1)
	

func Exit():
	OverlayUI.wheel_view.rotator.rotation_count_changed.disconnect(_on_count_changed)
	player.animation_player.play("Idle")

func Update(_delta: float):
	player.velocity.y = fixed_fly_speed * flying_speed_multiplier

func _on_count_changed(value : int):
	flying_speed_multiplier = value * -1
	if flying_speed_multiplier != 0:
		player.animation_player.play("fly",0.1, flying_speed_multiplier)
		_turn_rockets(value)
	else:
		_turn_rockets(1)
		player.animation_player.play("fly",0.1)

func _turn_rockets(side : int):
	var new_side = sign(side)
	var new_scale := Vector2(1.0,new_side)
	var tween_l : Tween = create_tween()
	var tween_r : Tween = create_tween()
	tween_l.tween_property(player.body_parts.propulsor_l,"scale",new_scale,0.1)
	tween_r.tween_property(player.body_parts.propulsor_r,"scale",new_scale,0.1)
	await tween_r.finished
	tween_l.kill()
	tween_r.kill()
