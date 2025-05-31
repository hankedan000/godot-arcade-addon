class_name ArcadeInputUtils
extends Object

const P1_ACTIONS = {"u": &"p1_up",
					"d": &"p1_down",
					"l": &"p1_left",
					"r": &"p1_right",
					"b": &"p1_button",
					"1": &"p1_start",
					"2": &"p2_start"}

const P2_ACTIONS = {"u": &"p2_up",
					"d": &"p2_down",
					"l": &"p2_left",
					"r": &"p2_right",
					"b": &"p2_button"}

static func set_ui_controller(is_p1: bool) -> void:
	InputMap.erase_action("ui_up")
	InputMap.erase_action("ui_down")
	InputMap.erase_action("ui_left")
	InputMap.erase_action("ui_right")
	InputMap.erase_action("ui_accept")
	
	InputMap.add_action("ui_up")
	InputMap.add_action("ui_down")
	InputMap.add_action("ui_left")
	InputMap.add_action("ui_right")
	InputMap.add_action("ui_accept")
	
	if TheArcade.cabinet_type == Arcade.CabinetType.Cocktail and not is_p1:
		# player two's UI is flipped 180degs in COCKTAIL_MODE
		InputMap.action_add_event("ui_up",    _get_action_event(is_p1,'d'))
		InputMap.action_add_event("ui_down",  _get_action_event(is_p1,'u'))
		InputMap.action_add_event("ui_left",  _get_action_event(is_p1,'r'))
		InputMap.action_add_event("ui_right", _get_action_event(is_p1,'l'))
		InputMap.action_add_event("ui_accept",_get_action_event(is_p1,'b'))
	else:
		InputMap.action_add_event("ui_up",    _get_action_event(is_p1,'u'))
		InputMap.action_add_event("ui_down",  _get_action_event(is_p1,'d'))
		InputMap.action_add_event("ui_left",  _get_action_event(is_p1,'l'))
		InputMap.action_add_event("ui_right", _get_action_event(is_p1,'r'))
		InputMap.action_add_event("ui_accept",_get_action_event(is_p1,'b'))

static func get_action(is_p1: bool, direction: String) -> StringName:
	if is_p1:
		return P1_ACTIONS[direction]
	else:
		return P2_ACTIONS[direction]
		
static func _get_action_event(is_p1: bool, direction: String):
	var action_name := get_action(is_p1,direction)
	var events := InputMap.action_get_events(action_name)
	
	if events.size() > 1:
		push_warning("There is more than 1 event in action '%s'; assuming first event." % action_name)
		
	if events.size() > 0:
		return events[0]
	else:
		return null
