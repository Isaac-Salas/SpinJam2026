extends Control
var pause : bool = false
@onready var resume: Button = $VBoxContainer/Resume
@onready var quit: Button = $VBoxContainer/Quit
@onready var reset: Button = $VBoxContainer/Reset
@onready var pause_button: TextureButton = $PauseButton


@onready var fondo: TextureRect = $Fondo


func _ready() -> void:
	resume.pressed.connect(_toggle_pause)
	pause_button.pressed.connect(_toggle_pause)
	quit.pressed.connect(_quit)
	reset.pressed.connect(_reset)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		_toggle_pause()

func _quit():
	get_tree().quit()

func _reset():
	_toggle_pause()
	OverlayUI.go_to_scene(0)
	OverlayUI.current_scene.start_music()

func _toggle_pause():
	pause = not pause
	get_tree().paused = pause
	if pause:
		_animate_fade(fondo,Color(1.0, 1.0, 1.0, 0.51),0.5)
		_animate_fade(resume,Color(1.0, 1.0, 1.0, 1.0),0.5)
		_animate_fade(quit,Color(1.0, 1.0, 1.0, 1.0),0.5)
		_animate_fade(reset,Color(1.0, 1.0, 1.0, 1.0),0.5)
		
	else:
		_animate_fade(resume,Color(1.0, 1.0, 1.0, 0.0),0.5)
		_animate_fade(quit,Color(1.0, 1.0, 1.0, 0.0),0.5)
		_animate_fade(reset,Color(1.0, 1.0, 1.0, 0.0),0.5)
		_animate_fade(fondo,Color(1.0, 1.0, 1.0, 0.0),0.5)



func _animate_fade(target : Control, new : Color, time : float):
	var tween := create_tween()
	tween.tween_property(target,"modulate",new,time)
	await tween.finished
	tween.kill()
	return
