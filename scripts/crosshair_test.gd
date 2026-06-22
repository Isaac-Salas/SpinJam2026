extends Node2D
class_name Crosshair
@export var state_machine : PlayerStateMachine
@onready var _1: Sprite2D = $"1"
@onready var _2: Sprite2D = $"2"
@onready var _3: Sprite2D = $"3"


func _ready() -> void:
	if state_machine:
		state_machine.state_changed.connect(_eval_croshair_visibility)
	


func _eval_croshair_visibility(current_state : State):
	var state_name : String = current_state.name.to_lower()
	if state_name == "shoot" or state_name == "aim" or state_name == "grapple":
		self.visible = true
	else:
		self.visible = false
