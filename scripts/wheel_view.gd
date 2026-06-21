extends Control
class_name WheelControl
@onready var rotator: SpinningWheel = $Rotador
@onready var screen_text: RichTextLabel = $"Buttons&Indicators/Pantalla/ScreenText"
@onready var move: TextureButton = $"Buttons&Indicators/ButtonsRow1/Move"
@onready var jump: TextureButton = $"Buttons&Indicators/ButtonsRow1/Jump"
@onready var shoot: TextureButton = $"Buttons&Indicators/ButtonsRow1/Shoot"
@onready var aim: TextureButton = $"Buttons&Indicators/ButtonsRow2/Aim"
@onready var fly: TextureButton = $"Buttons&Indicators/ButtonsRow2/Fly"
@onready var grapple: TextureButton = $"Buttons&Indicators/ButtonsRow2/Grapple"
@onready var energy: ProgressBar = $"Buttons&Indicators/Bar&Button/Energy"
@onready var activate: TextureButton = $"Buttons&Indicators/Bar&Button/Activate"
@onready var light_left_up: TextureRect = $"Buttons&Indicators/Indicators/Left_Up/Light"
@onready var light_right_down: TextureRect = $"Buttons&Indicators/Indicators/RightDown/Light"

var current_state : String:
	set(value):
		if value != current_state:
			current_state = value
			state_change.emit(current_state)

signal state_change(state)

func _ready() -> void:
	move.pressed.connect(_on_state_button_press.bind("move"))
	jump.pressed.connect(_on_state_button_press.bind("jump"))
	shoot.pressed.connect(_on_state_button_press.bind("shoot"))
	aim.pressed.connect(_on_state_button_press.bind("aim"))
	fly.pressed.connect(_on_state_button_press.bind("fly"))
	grapple.pressed.connect(_on_state_button_press.bind("grapple"))
	rotator.rotation_side_change.connect(update_side_indicator)
	


func _on_state_button_press(state : String):
	update_screen(state)
	state_change.emit(state)
	
func update_screen(text : String):
	screen_text.text = "[wave amp=50.0 freq=2.0 connected=0]"
	screen_text.text += text

func update_side_indicator(side : String):
	if side != "":
		if side == "left":
			light_left_up.visible = true
			light_right_down.visible = false
		elif side == "right":
			light_right_down.visible = true
			light_left_up.visible = false
	else:
		light_left_up.visible = false
		light_right_down.visible = false
