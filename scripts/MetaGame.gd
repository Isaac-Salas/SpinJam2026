extends Node
class_name META
var Id : String = "JellyDog/Spinamo"
#id: JellyDog/Spinamo
#title: Spinamo
#description: A small game about a small wheel-powered robot!
#url: https://jellydogstudio.itch.io/spinamo
#saveKey: JellyDog/Spinamo

func meta_game_complete(gameId: String) -> void:
	if OS.has_feature("web"):
		JavaScriptBridge.eval("localStorage.setItem(\"%s\", new Date().toJSON());" % gameId)
