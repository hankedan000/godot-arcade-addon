class_name ArcadePlayerInput
extends Node

@export var is_player1 : bool = true

signal dir_pressed(dir)

var _inputMapStack = []

func _input(event):
	var DIRS = ['u','d','l','r']
	
	for dir in DIRS:
		if event.is_action_pressed(ArcadeInputUtils.get_action(is_player1,dir)):
			dir_pressed.emit(dir)

func take_ui_control():
#	push_map()
	ArcadeInputUtils.set_ui_controller(is_player1)

func restore_ui_control():
#	pop_map()
	pass

func push_map():
	# create a dictionary that contains the current mapping
	var history = {}
	for action in InputMap.get_actions():
		history[action] = []
		for event in InputMap.action_get_events(action):
			history[action].append(event)
	
	_inputMapStack.push_back(history)
		
func pop_map():
	if _inputMapStack.size() > 0:
		# clear out current mapping
		for action in InputMap.get_actions():
			InputMap.erase_action(action)
			
		# pop and restore previous mapping
		var history = _inputMapStack.pop_back()
		for action in history.keys():
			var events = history[action]
			InputMap.add_action(action)
			for event in events:
				InputMap.action_add_event(action,event)
				history[action].append(event)
	else:
		push_warning("Tried to pop InputMap, but nothing available.")

func get_player_action(direction):
	return ArcadeInputUtils.get_action(is_player1,direction)
