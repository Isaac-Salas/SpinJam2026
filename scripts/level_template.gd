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
@export var fail_dialog : DialogueResource

func _ready() -> void:
	await SoundManager.ready
	SoundManager.cross_fade_to_song(SoundManager.get(level_music_name.to_upper()))
	unlocks()


func win():
	OverlayUI.transitions.start_transition(ending_dialog,"start")
	SoundManager.cross_fade_to_song(SoundManager.NEWS,4.0)

func lose():
	OverlayUI.transitions.start_transition(ending_dialog,"start")
	SoundManager.cross_fade_to_song(SoundManager.NEWS,4.0)

func unlocks():
	OverlayUI.wheel_view.player_move = player_move
	OverlayUI.wheel_view.player_jump = player_jump
	OverlayUI.wheel_view.player_shoot = player_shoot
	OverlayUI.wheel_view.player_aim = player_aim
	OverlayUI.wheel_view.player_fly = player_fly
	OverlayUI.wheel_view.player_grapple = player_grapple
	OverlayUI.wheel_view.update_unlocks()
