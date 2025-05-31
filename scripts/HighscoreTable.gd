extends Object
class_name HighscoreTable

signal new_score_added()

@export var max_highscores: int = 10

var _highscores : Array[Highscore] = []

func _ready():
	pass # Replace with function body.
	
func _getInsertIndex(highscore: Highscore):
	return _highscores.bsearch_custom(highscore, Highscore.highestThenOldest, false)

func getHighscores() -> Array[Highscore]:
	return _highscores
	
func isHighscore(score: int) -> bool:
	# make a temporary highscore so we can compare
	var tempHighscore = Highscore.new("temp_player",score)
	
	# find where the score would be inserted if it were a new highscore
	var index = _getInsertIndex(tempHighscore)
	
	return index < max_highscores
	
func addHighscore(highscore: Highscore) -> void:
	# insert the new score to the list
	_highscores.append(highscore)
	_highscores.sort_custom(Callable(Highscore, "highestAndOldest"))
	
	# remove the lowest score
	if _highscores.size() > max_highscores:
		_highscores.pop_back()
	
	new_score_added.emit()
	
func save_game() -> Dictionary:
	var highscoreData = []
	for highscore in _highscores:
		highscoreData.append(highscore.save_game())
		
	var data = {
		highscores = highscoreData
		}
	return data
	
func load_game(data: Dictionary) -> void:
	for scoreData in data["highscores"]:
		var hs = Highscore.new("temp",0)
		hs.load_game(scoreData)
		addHighscore(hs)
