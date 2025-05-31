class_name Arcade
extends Node

enum CabinetType {
	Standup, Cocktail
}

var cabinet_type : CabinetType = CabinetType.Standup

# if true ...
#  * game runs full screen
#  * mouse is hidden
#  * shows arcade-specific control graphics (ie. control panel artwork)
var _arcade_mode : bool = false

func _ready() -> void:
	if OS.has_feature("arcade_mode"):
		_arcade_mode = true
		# hide the mouse when hovering over game
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# default player 1 to the UI controller
	ArcadeInputUtils.set_ui_controller(true)

func is_arcade_mode() -> bool:
	return _arcade_mode
