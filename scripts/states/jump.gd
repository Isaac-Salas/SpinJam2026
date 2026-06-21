extends State
class_name Jump
@export var energy_count : int
@export var max_limit : int = 3
@export var min_limit : int = 0
@export var fixed_jump_speed : float = 180


func Enter():
	OverlayUI.wheel_view.tween_update_energy_bar(energy_count)
	OverlayUI.wheel_view.rotator.rotation_count_changed.connect(update_energy_count)
	OverlayUI.wheel_view.activate.pressed.connect(jump)

func Exit():
	OverlayUI.wheel_view.rotator.rotation_count_changed.disconnect(update_energy_count)
	OverlayUI.wheel_view.activate.pressed.disconnect(jump)

func update_energy_count(value : int):
	if value != 0:
		energy_count += sign(value)
		energy_count = clamp(energy_count,min_limit,max_limit)
		OverlayUI.wheel_view.tween_update_energy_bar(energy_count)
	print(energy_count)

func reset_energy_count():
	energy_count = 0
	OverlayUI.wheel_view.tween_update_energy_bar(energy_count)

func jump():
	if player.is_on_floor():
		player.velocity.y = - fixed_jump_speed * energy_count
		reset_energy_count()
		player.animation_player.play("jump",-1,1.0)
		await player.animation_player.animation_finished
		player.animation_player.play("Idle",0.2,1.0)
