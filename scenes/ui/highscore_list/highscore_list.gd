class_name HighscoreList
extends Container

@export var max_scores_to_show: int = 5

@onready var score_list:= $ScrollContainer/VBoxContainer
@onready var base_entry:= $ScrollContainer/VBoxContainer/BaseEntry

func _ready() -> void:
	TheHighscoreDatabase.new_score_added.connect(_on_HighscoreDatabase_new_score_added)
	base_entry.get_parent().remove_child(base_entry)
	queue_ui_update()

func _process(_delta: float) -> void:
	_update_ui()
	set_process(false)

func queue_ui_update() -> void:
	set_process(true)

# clears the scroll list and re-add to the panel
func _update_ui() -> void:
	for entry in score_list.get_children():
		entry.queue_free()
		
	var i:= 0
	for highscore in TheHighscoreDatabase.get_highscores():
		var new_entry:= base_entry.duplicate()
		new_entry.get_node("place").text = "%d:" % [i+1]
		new_entry.get_node("name").text = highscore.player_name
		new_entry.get_node("score").text = str(highscore.score)
		new_entry.visible = true
		score_list.add_child(new_entry)
		i += 1
		
		if i > max_scores_to_show:
			break
		
func _on_HighscoreDatabase_new_score_added() -> void:
	queue_ui_update()
