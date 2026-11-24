extends Control
var pause : bool = false
@onready var resume: Button = $VBoxContainer/Resume
@onready var quit: Button = $VBoxContainer/Quit
@onready var reload: Button = $VBoxContainer/Reload
@onready var reset: Button = $VBoxContainer/Reset
@onready var pause_button: TextureButton = $PauseButton


@onready var fondo: TextureRect = $Fondo


func _ready() -> void:
	resume.pressed.connect(_resume)
	pause_button.pressed.connect(_toggle_pause)
	reload.pressed.connect(_reload)
	quit.pressed.connect(_quit)
	reset.pressed.connect(_reset)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		_toggle_pause()

func _resume():
	button_tween(resume)
	_toggle_pause()

func _quit():
	button_tween(quit)
	get_tree().quit()

func _reload():
	button_tween(reload)
	_toggle_pause()
	OverlayUI.reload_scene()

func _reset():
	button_tween(reset)
	_toggle_pause()
	OverlayUI.go_to_scene(0)
	OverlayUI.current_scene.start_music()

func _toggle_pause():
	
	pause = not pause
	get_tree().paused = pause
	if pause:
		_animate_fade(fondo,Color(1.0, 1.0, 1.0, 0.667),0.5)
		_animate_fade(resume,Color(1.0, 1.0, 1.0, 1.0),0.5)
		_animate_fade(quit,Color(1.0, 1.0, 1.0, 1.0),0.5)
		_animate_fade(reset,Color(1.0, 1.0, 1.0, 1.0),0.5)
		_animate_fade(reload,Color(1.0, 1.0, 1.0, 1.0),0.5)
		
	else:
		_animate_fade(resume,Color(1.0, 1.0, 1.0, 0.0),0.5)
		_animate_fade(quit,Color(1.0, 1.0, 1.0, 0.0),0.5)
		_animate_fade(reset,Color(1.0, 1.0, 1.0, 0.0),0.5)
		_animate_fade(fondo,Color(1.0, 1.0, 1.0, 0.0),0.5)
		_animate_fade(reload,Color(1.0, 1.0, 1.0, 0.0),0.5)

func button_tween(target : Control):
	var tween : Tween = create_tween()
	var new_scale := Vector2(1.5,1.5)
	tween.tween_property(target,"offset_transform_scale",new_scale,0.1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(target,"offset_transform_scale",Vector2.ONE,0.1).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
	tween.kill()

func _animate_fade(target : Control, new : Color, time : float):
	var tween := create_tween()
	tween.tween_property(target,"modulate",new,time)
	await tween.finished
	tween.kill()
	return
