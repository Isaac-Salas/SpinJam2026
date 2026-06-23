extends Node2D
@export_group("Music")
@export var level_music_name : String
@export_group("Unlocks")
@export var player_move : bool = true
@export var player_jump : bool
@export var player_shoot : bool
@export var player_aim : bool
@export var player_fly : bool
@export var player_grapple : bool
@export_group("Dialog")
@export var ending_dialog : DialogueResource

func _ready() -> void:
	pass


func win():
	OverlayUI.transitions.start_transition(ending_dialog,"start")
	SoundManager.cross_fade_to_song(SoundManager.get(level_music_name.to_upper()))

func lose():
	pass
