extends Object
class_name Highscore

var _score: int = 0
var _epochTime: int = 0
var _playerName: String = ""

func _init(playerName: String, score: int):
	_score = score
	_epochTime = Time.get_unix_time_from_system()
	_playerName = playerName
	
func score():
	return _score
	
func epochTime():
	return _epochTime
	
func playerName():
	return _playerName
	
static func highestThenOldest(lhs: Highscore, rhs: Highscore) -> bool:
	if lhs.score() > rhs.score():
		return true
	elif lhs.score() < rhs.score():
		return false
	elif lhs.epochTime() < rhs.epochTime():
		# older scores have higher precedance than newer scores
		return true
	return false
	
func save_game() -> Dictionary:
	var saveDict = {
			score      = _score,
			epochTime  = _epochTime,
			playerName = _playerName
		}
	return saveDict

func load_game(saveDict: Dictionary) -> void:
	_score      = saveDict["score"]
	_epochTime  = saveDict["epochTime"]
	_playerName = saveDict["playerName"]
