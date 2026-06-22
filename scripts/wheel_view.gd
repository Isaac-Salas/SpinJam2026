extends Control
class_name WheelControl
@export var initial_screen_text : String 
@export_group("Unlocks")
@export var player_move : bool = true
@export var player_jump : bool
@export var player_shoot : bool
@export var player_aim : bool
@export var player_fly : bool
@export var player_grapple : bool
@onready var rotator: SpinningWheel = $Rotador
@onready var screen_text: RichTextLabel = $"Buttons&Indicators/Pantalla/ScreenText"
@onready var move: TextureButton = $"Buttons&Indicators/ButtonsRow1/Move"
@onready var jump: TextureButton = $"Buttons&Indicators/ButtonsRow1/Jump"
@onready var shoot: TextureButton = $"Buttons&Indicators/ButtonsRow1/Shoot"
@onready var aim: TextureButton = $"Buttons&Indicators/ButtonsRow2/Aim"
@onready var fly: TextureButton = $"Buttons&Indicators/ButtonsRow2/Fly"
@onready var grapple: TextureButton = $"Buttons&Indicators/ButtonsRow2/Grapple"
@onready var bar_button: HBoxContainer = $"Buttons&Indicators/Bar&Button"
@onready var energy: TextureProgressBar = $"Buttons&Indicators/Bar&Button/Energy"
@onready var activate: TextureButton = $"Buttons&Indicators/Bar&Button/Activate"
@onready var light_left_up: TextureRect = $"Buttons&Indicators/Indicators/Left_Up/Light"
@onready var light_right_down: TextureRect = $"Buttons&Indicators/Indicators/RightDown/Light"
@onready var screen_light: TextureRect = $"Buttons&Indicators/Pantalla/Light"
@onready var bar_light: TextureRect = $"Buttons&Indicators/Bar&Button/Energy/Light"
@export var color_dictionary : Dictionary[String,Color]={
	"move" : Color(1.0, 1.0, 1.0, 1.0),
	"jump" : Color(1.0, 1.0, 1.0, 1.0),
	"shoot" : Color(1.0, 1.0, 1.0, 1.0),
	"aim" : Color(1.0, 1.0, 1.0, 1.0),
	"fly" : Color(1.0, 1.0, 1.0, 1.0),
	"grapple" : Color(1.0, 1.0, 1.0, 1.0)
}


var current_state : String:
	set(value):
		if value != current_state:
			current_state = value
			state_change.emit(current_state)

signal state_change(state)
signal energy_bar_updated

func _ready() -> void:
	_on_state_button_press(initial_screen_text)
	update_unlocks()
	move.pressed.connect(_on_state_button_press.bind("move"))
	jump.pressed.connect(_on_state_button_press.bind("jump"))
	shoot.pressed.connect(_on_state_button_press.bind("shoot"))
	aim.pressed.connect(_on_state_button_press.bind("aim"))
	fly.pressed.connect(_on_state_button_press.bind("fly"))
	grapple.pressed.connect(_on_state_button_press.bind("grapple"))
	rotator.rotation_side_change.connect(update_side_indicator)
	energy_bar_updated.connect(on_update_energy_bar)
	


func _on_state_button_press(state : String):
	update_screen(state)
	update_modular_color(state)
	eval_energy_bar(state)
	state_change.emit(state)

func update_screen(text : String):
	screen_text.text = "[wave amp=50.0 freq=2.0 connected=0]"
	screen_text.text += text.to_pascal_case()
	screen_text_tween()

func screen_text_tween():
	var tween : Tween = create_tween()
	var new_scale := Vector2(1.5,1.5)
	tween.tween_property(screen_text,"offset_transform_scale",new_scale,0.1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(screen_text,"offset_transform_scale",Vector2.ONE,0.1).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
	tween.kill()

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

func update_unlocks():
	move.disabled = not player_move
	jump.disabled = not player_jump
	shoot.disabled = not player_shoot
	aim.disabled = not player_aim
	fly.disabled = not player_fly
	grapple.disabled = not player_grapple

func eval_energy_bar(state : String):
	if state == "jump" or state == "grapple":
		toggle_energy(true)
	else:
		toggle_energy(false)

func toggle_energy(value : bool):
	#activate.disabled = not value
	if value:
		bar_button.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		bar_button.modulate = Color(0.35, 0.35, 0.35, 1.0)
		tween_update_energy_bar(0)

func tween_update_energy_bar(new_value : float):
	var tween : Tween = create_tween()
	tween.tween_property(energy,"value",new_value,0.1)
	await tween.finished
	energy_bar_updated.emit()
	tween.kill()

func on_update_energy_bar():
	if energy.value == 0:
		activate.disabled = true
		bar_light.visible = false
	else:
		energy_bar_tween()
		activate.disabled = false
		bar_light.visible = true

func energy_bar_tween():
	var tween : Tween = create_tween()
	var new_rotation := 15
	tween.tween_property(energy,"offset_transform_rotation",deg_to_rad(new_rotation),0.05).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(energy,"offset_transform_rotation",0,0.05).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
	tween.kill()

func update_modular_color(new_color_name : String):
	var new_color: Color = color_dictionary[new_color_name]
	var new_color_transparent := Color(new_color,0.588)
	energy.tint_progress = new_color
	rotator.rotation_counter.add_theme_color_override("font_color",new_color)
	screen_text.add_theme_color_override("default_color",new_color)
	bar_light.modulate = new_color_transparent
	screen_light.modulate = new_color_transparent
	
