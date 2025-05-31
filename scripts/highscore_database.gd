class_name HighscoreDatabase
extends PersistentUserDataNode

const KEY_HIGHSCORES = &'highscores'

signal new_score_added()

@export var max_highscores: int = 10

var _highscores : Array[Highscore] = []

func _init() -> void:
	super("user://highscore_db.json")

func get_highscores() -> Array[Highscore]:
	return _highscores.duplicate(true) # return a copy

func is_highscore(score: int) -> bool:
	# make a temporary highscore so we can compare
	var temp := Highscore.make_new_now("temp_player", score)
	
	# find where the score would be inserted if it were a new highscore
	var index = _get_insert_index(temp)
	
	return index < max_highscores

func add_highscore(highscore: Highscore) -> void:
	# insert the new score to the list
	_highscores.append(highscore)
	_highscores.sort_custom(Highscore.compare_highest_then_oldest)
	
	# remove the lowest score
	if _highscores.size() > max_highscores:
		_highscores.pop_back()
	
	new_score_added.emit()
	queue_save()

# overrides PersistentUserDataNode.to_dict()
func to_dict() -> Dictionary:
	var highscores := []
	for highscore in _highscores:
		highscores.append(highscore.to_dict())
		
	var out_dict:= {}
	out_dict[KEY_HIGHSCORES] = highscores
	return out_dict

# overrides PersistentUserDataNode.restore_from_dict()
func restore_from_dict(data: Dictionary) -> void:
	for score_data in DictUtils.get_w_default(data, KEY_HIGHSCORES, []):
		add_highscore(Highscore.from_dict(score_data))

func _get_insert_index(highscore: Highscore) -> int:
	return _highscores.bsearch_custom(highscore, Highscore.compare_highest_then_oldest, false)
