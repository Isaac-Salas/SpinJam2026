extends Node
class_name ViewportLoader
@export var target_game_view : SubViewport
@export var target_hand_view : SubViewport



func _process(_delta: float) -> void:
	if target_game_view:
		_set_viewport_gameview()
	if target_hand_view:
		_set_viewport_handview()


func _set_viewport_gameview():
	UI.game_view.texture = target_game_view.get_texture()


func _set_viewport_handview():
	UI.hand_view.texture = target_hand_view.get_texture()
