class_name Keyboard
extends Panel

signal char_entered(c: String)
signal rub
signal end

@export var is_player1: bool = true
@export var hide_on_end: bool = true

@onready var key_grid:= $keyGrid
@onready var a_key:= $keyGrid/a
@onready var player_input: ArcadePlayerInput = $PlayerInput

func _ready():
	set_is_player1(is_player1)
	_try_grab_focus()
	
	for button in key_grid.get_children():
		if button is BaseButton:
			button.pressed.connect(_on_key_pressed.bind(button.name))
		
func set_is_player1(isP1):
	is_player1 = isP1
	player_input.is_player1 = isP1

func _on_key_pressed(name: StringName):
	match(name):
		&"period":
			char_entered.emit('.')
		&"hyphen":
			char_entered.emit('-')
		&"rub":
			rub.emit()
		&"end":
			end.emit()
			if hide_on_end:
				hide()
		_:
			char_entered.emit(name)

func _try_grab_focus() -> void:
	if visible && player_input && is_inside_tree():
		player_input.take_ui_control()
		a_key.grab_focus()

func _on_hidden() -> void:
	player_input.restore_ui_control()

func _on_visibility_changed() -> void:
	_try_grab_focus()
