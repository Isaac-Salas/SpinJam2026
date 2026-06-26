extends Node
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var override_and_play : bool

func _ready() -> void:
	OverlayUI.transitions.transition_ending.connect(_play_ending_animation)
	if override_and_play:
		_play_ending_animation()
	

func _play_ending_animation():
	animation_player.play("fade_in")
	
