extends Node2D
class_name Level

@export_group("Overrides")
@export var ui_screen_text : String
@export var auto_win : bool
@export_group("Music")
@export var play_music_on_ready : bool
@export var level_music_name : String
@export_range(1.0,20.0,0.1) var volume : float = 1
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
@export_group("Player")
@export var player : Player

signal level_started
signal music_started
signal level_won
signal level_lost

func _ready() -> void:
	start_level()
	level_started.emit()
	if play_music_on_ready:
		await SoundManager.ready
		start_music()
	if auto_win:
		win()

func start_level():
	OverlayUI.wheel_view.rotator.toggle_disable(false)
	unlocks()
	override_ui_screen_text()
	if player:
		player.update_unlocks()

func start_music():
	SoundManager.cross_fade_to_song(SoundManager.get(level_music_name.to_upper()),volume)
	music_started.emit()

func win():
	OverlayUI.wheel_view.rotator.toggle_disable(true)
	OverlayUI.transitions.start_transition(ending_dialog,"start")
	SoundManager.cross_fade_to_song(SoundManager.NEWS,4.0)
	level_won.emit()

func lose():
	print("LOSE")
	OverlayUI.wheel_view.rotator.toggle_disable(true)
	OverlayUI.transitions.start_transition(fail_dialog,"start")
	SoundManager.cross_fade_to_song(SoundManager.NEWS,4.0)
	level_lost.emit()

func unlocks():
	OverlayUI.wheel_view.player_move = player_move
	OverlayUI.wheel_view.player_jump = player_jump
	OverlayUI.wheel_view.player_shoot = player_shoot
	OverlayUI.wheel_view.player_aim = player_aim
	OverlayUI.wheel_view.player_fly = player_fly
	OverlayUI.wheel_view.player_grapple = player_grapple
	OverlayUI.wheel_view.update_unlocks()

func override_ui_screen_text():
	if ui_screen_text != "":
		OverlayUI.wheel_view.update_screen(ui_screen_text)
