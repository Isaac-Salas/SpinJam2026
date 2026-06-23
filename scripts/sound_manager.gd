extends Node
@onready var music_game: AudioStreamPlayer = $MusicGame
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
	play_song(BOSS_FULL)
	OverlayUI.wheel_view.rotator.rotation_count_changed.connect(play_wheel_turn.unbind(1))
	OverlayUI.wheel_view.state_button_pressed.connect(play_sfx.bind(BUTTON_PRESS, 2.0,3.0))
	OverlayUI.wheel_view.bar_button_pressed.connect(play_sfx.bind(ENERGY_BUTTON_PRESS,1.5,2.0))

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

func play_news_song():
	var new_stream : AudioStream = NEWS.duplicate()
	new_stream.loop = true
	music_news.stream = new_stream
	music_news.play()

func stop_news_song():
	music_news.stop()
