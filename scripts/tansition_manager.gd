extends Control
class_name TransitionManager
@onready var game_screenshot: TextureRect = $GameScreenshot
@onready var stripe: TextureRect = $Stripe
@onready var text: Label = $Stripe/Text
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const TEST = preload("uid://dwkdjgw8bob68")

func _ready() -> void:
	pass
	#play_transition_in_animation()

func take_screenshot():
	await RenderingServer.frame_post_draw
	var image = get_viewport().get_texture().get_image()
	var texture_test = ImageTexture.create_from_image(image)
	game_screenshot.texture = texture_test

func play_transition_in_animation():
	take_screenshot()
	animation_player.play("Breaking_News")
	await animation_player.animation_finished
	DialogueManager.show_dialogue_balloon(TEST, "start")

func play_transition_out():
	animation_player.play("OUT")
	
