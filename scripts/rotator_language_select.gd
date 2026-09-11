extends Node
@export var rotator : SpinningWheel
@export var screen : StandaloneScreen
@export var ok_button : TextureButton
@export var reparenter : Reparenter
@export var languages : Dictionary[String,String]

var current_language : String = 'en'


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if rotator:
		rotator.rotation_count_changed.connect(_on_rotator_count_change)
	if ok_button:
		ok_button.pressed.connect(_on_ok_press)
	_update_screen_language()

func _on_ok_press():
	reparenter.return_og_parent()
	OverlayUI.go_to_next_scene()

func _on_rotator_count_change(value : int):
	SoundManager.play_wheel_turn()
	if value != 0:
		_next_language_select()
		_update_screen_language()

func _next_language_select():
	for language in languages:
		if language != current_language:
			current_language = language
			TranslationServer.set_locale(current_language)
			return current_language
		else:
			continue

func _update_screen_language():
	var language = languages.get(current_language)
	screen.update_screen(language)
