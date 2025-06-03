class_name NameDialog
extends VBoxContainer

signal name_entered(name: String)

@export var is_player1 = true
@export var caps_lock_on = true
@export var caps_first_letter = true

@onready var line: LineEdit = $LineEdit
@onready var keyboard: Keyboard = $Keyboard

func _ready() -> void:
	clear_text()
	set_is_player1(is_player1)
	
func set_is_player1(isP1: bool) -> void:
	is_player1 = isP1
	keyboard.set_is_player1(isP1)
	
func clear_text() -> void:
	line.text = ""

func _on_keyboard_char_entered(c: String) -> void:
	if caps_lock_on:
		c = c.to_upper()
	elif caps_first_letter and line.text.length() == 0:
		c = c.to_upper()
	
	line.text += c

func _on_keyboard_rub() -> void:
	var oldStr = line.text
	line.text = oldStr.substr(0,oldStr.length()-1)

func _on_keyboard_end() -> void:
	name_entered.emit(line.text)
	hide()
