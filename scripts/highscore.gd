class_name Highscore
extends Object

const KEY_SCORE := &'score'
const KEY_EPOCH_TIME := &'epoch_time'
const KEY_PLAYER_NAME := &'player_name'

var player_name: String = ""
var epoch_time: int = 0
var score: int = 0

func _init(player_name: String, epoch_time: int, score: int):
	self.player_name = player_name
	self.epoch_time = Time.get_unix_time_from_system()
	self.score = score

static func make_new_now(player_name: String, score: int) -> Highscore:
	var time_now := Time.get_unix_time_from_system()
	return Highscore.new(player_name, time_now, score)

static func from_dict(data: Dictionary) -> Highscore:
	var player_name := data[KEY_PLAYER_NAME] as String
	var epoch_time := data[KEY_EPOCH_TIME] as int
	var score := data[KEY_SCORE] as int
	return Highscore.new(player_name, epoch_time, score)

static func compare_highest_then_oldest(lhs: Highscore, rhs: Highscore) -> bool:
	if lhs.score > rhs.score:
		return true
	elif lhs.score < rhs.score:
		return false
	elif lhs.epoch_time < rhs.epoch_time:
		# older scores have higher precedance than newer scores
		return true
	return false
	
func to_dict() -> Dictionary:
	var out_dict:= {}
	out_dict[KEY_PLAYER_NAME] = player_name
	out_dict[KEY_EPOCH_TIME] = epoch_time
	out_dict[KEY_SCORE] = score
	return out_dict
