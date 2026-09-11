extends TextureRect
class_name StandaloneScreen
@export var screen_text: RichTextLabel

func update_screen(text : String):
	screen_text.text = "[wave amp=50.0 freq=2.0 connected=0]"
	screen_text.text += text.to_pascal_case()
	screen_text_tween()

func screen_text_tween():
	var tween : Tween = create_tween()
	var new_scale := Vector2(1.5,1.5)
	tween.tween_property(screen_text,"offset_transform_scale",new_scale,0.1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(screen_text,"offset_transform_scale",Vector2.ONE,0.1).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
	tween.kill()
