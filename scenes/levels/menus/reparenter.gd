extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await OverlayUI.ready
	var parent = get_parent()
	parent.reparent(get_tree().current_scene)
	OverlayUI.toggle_visible(false)
