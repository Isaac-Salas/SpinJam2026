extends Node

@onready var music_game: AudioStreamPlayer = $MusicGame
@onready var music_game_buffer: AudioStreamPlayer = $MusicGameBuffer
@onready var music_news: AudioStreamPlayer = $MusicNews

@onready var sfx: AudioStreamPlayer = $SFX

const MAIN_FULL = preload("uid://bhlcx3361hdle")
const MAIN_DRUMS = preload("uid://bw66dlj48lsrc")
const MAIN_INSTRUMENTS = preload("uid://bxd8uu6huu5ai")
const BOSS_DRUMS = preload("uid://b4rvvoiabfvgs")
const BOSS_FULL = preload("uid://chexuo8huap0s")
const WHEEL_TURN = preload("uid://7k53shuv25fx")
const NEWS = preload("uid://bb5cfo5w70wsg")
const BUTTON_PRESS = preload("uid://cp0kebs4tjn2q")
const ENERGY_BUTTON_PRESS = preload("uid://dbifmuc3oscr1")

func _ready() -> void:
	#play_news_song()

	#await get_tree().create_timer(5.0).timeout
	#await cross_fade_to_song(NEWS,4.0)
	#cross_fade_to_song(MAIN_FULL,1.0)
	OverlayUI.wheel_view.rotator.rotation_count_changed.connect(play_wheel_turn.unbind(1))
	OverlayUI.wheel_view.state_button_pressed.connect(play_sfx.bind(BUTTON_PRESS, 2.0,3.0))
	OverlayUI.wheel_view.bar_button_pressed.connect(play_sfx.bind(ENERGY_BUTTON_PRESS,1.5,2.0))
	cross_fade_to_song(MAIN_FULL)

func play_wheel_turn():
	play_sfx(WHEEL_TURN)

func play_sfx(SFX : AudioStream, min_pitch : float = 1.0, max_pitch : float = 3.0):
	sfx.stream = SFX
	sfx.pitch_scale = randf_range(min_pitch,max_pitch)
	sfx.play()
	

func play_song(song : AudioStream):
	var new_stream : AudioStream = song.duplicate()
	new_stream.loop = true
	music_game.stream = new_stream
	music_game.play()


func cross_fade_to_song(new_song : AudioStream, new_custom_volume = 1.0) -> bool:
	var last_song_stream : AudioStream = music_game.stream
	var last_song_position : float = music_game.get_playback_position()
	var original_volume : float = music_game.volume_db
	_stop_all_players()
	music_game_buffer.stream = last_song_stream
	music_game_buffer.volume_db = original_volume
	music_game_buffer.play(last_song_position)
	music_game.volume_db = -80
	music_game.stream = new_song
	music_game.play()
	var tween_music : Tween = create_tween()
	tween_music.parallel().tween_property(music_game,"volume_db",new_custom_volume,0.1)
	tween_music.parallel().tween_property(music_game_buffer,"volume_db",-80,1.0)
	await tween_music.finished
	music_game_buffer.stop()
	tween_music.kill()
	return true


func _stop_all_players():
	music_game.stop()
	music_game_buffer.stop()
