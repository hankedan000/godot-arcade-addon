extends Panel

@export var is_player1 = true

signal char_entered(c)
signal rub
signal end

func _ready():
	set_is_player1(is_player1)
	
	for button in $keyGrid.get_children():
		button.connect("pressed", Callable(self, "_onKeyPressed").bind(button.name))
		
func set_is_player1(isP1):
	is_player1 = isP1
	$PlayerInput.is_player1 = isP1

func _onKeyPressed(name: String):
	match(name):
		"period":
			emit_signal("char_entered",'.')
		"hyphen":
			emit_signal("char_entered",'-')
		"rub":
			emit_signal("rub")
		"end":
			emit_signal("end")
		_:
			emit_signal("char_entered",name)

func _on_ArcadeKeyboard_hide():
	$PlayerInput.restore_ui_control()

func _on_ArcadeKeyboard_visibility_changed():
	if visible:
		$PlayerInput.take_ui_control()
		$keyGrid/a.grab_focus()
