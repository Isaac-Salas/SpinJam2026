extends State
class_name Fly
@export var fixed_fly_speed : float = 100
var flying_speed_multiplier : int


func Enter():
	player.use_gavity = false
	OverlayUI.wheel_view.rotator.rotation_count_changed.connect(_on_count_changed)

func Exit():
	OverlayUI.wheel_view.rotator.rotation_count_changed.disconnect(_on_count_changed)

func Update(_delta: float):
	player.velocity.y = fixed_fly_speed * flying_speed_multiplier

func _on_count_changed(value : int):
	flying_speed_multiplier = value * -1
	#if flying_speed_multiplier != 0:
		#player.animation_player.play("run",0.1,running_speed_multiplier)
	#else:
		#player.animation_player.play("Idle")
