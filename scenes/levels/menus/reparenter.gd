extends Node
class_name Reparenter
var og_parent : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	og_parent = get_parent().get_parent()
	reparent_to_top()
	

func reparent_to_top():
	await OverlayUI.ready
	var parent = get_parent()
	parent.reparent(get_tree().current_scene)
	OverlayUI.toggle_visible(false)

func return_og_parent():
	var parent = get_parent()
	parent.reparent(og_parent)
	OverlayUI.toggle_visible(true)
