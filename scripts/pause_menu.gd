extends Control
var pause : bool = false
@onready var resume: Button = $Resume
@onready var quit: Button = $Quit
@onready var reset: Button = $Reset


func _ready() -> void:
	resume.pressed.connect(_toggle_pause)
	quit.pressed.connect(_quit)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		_toggle_pause()

func _quit():
	get_tree().quit()

func _toggle_pause():
	pause = not pause
	get_tree().paused = pause
	visible = pause
