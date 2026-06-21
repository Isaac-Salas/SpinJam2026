extends Node
class_name PlayerStateMachine
@export var initial_state : State
var current_state : State
var states : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OverlayUI.wheel_view.state_change.connect(transition_to_new_state)
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func transition_to_new_state(new_state_name : String):
	var new_state : State = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.Exit()
	new_state.Enter()
	current_state = new_state
