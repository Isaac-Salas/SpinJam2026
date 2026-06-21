extends Node
class_name ViewportLoader
@export var target_game_view : SubViewport

func _process(_delta: float) -> void:
	if target_game_view:
		_set_viewport_gameview()

func _set_viewport_gameview():
	OverlayUI.game_view.texture = target_game_view.get_texture()
