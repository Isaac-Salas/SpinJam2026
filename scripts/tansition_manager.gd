extends Control
class_name TransitionManager
@onready var game_screenshot: TextureRect = $GameScreenshot
@onready var stripe: TextureRect = $Stripe
@onready var text: Label = $Stripe/Text
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	#play_transition_in_animation()
	pass


func take_screenshot():
	var image = get_viewport().get_texture().get_image()
	var texture_test = ImageTexture.create_from_image(image)
	game_screenshot.texture = texture_test

func start_transition(dialogue : DialogueResource, start_at : String):
	take_screenshot()
	animation_player.play("Breaking_News")
	await animation_player.animation_finished
	if dialogue:
		DialogueManager.show_dialogue_balloon(dialogue, start_at)


func finish_transition():
	animation_player.play("OUT")
	
