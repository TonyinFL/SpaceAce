extends Node

var score: int = 0:
	get: return score

var high_score: int = 0:
	get: return high_score


func increment_score(value: int) -> void:
	score += value
	if high_score < score:
		high_score = score
	SignalHub.on_score_updated.emit(score)
	

func reset_score() -> void:
	score = 0
	SignalHub.on_score_updated.emit(score)
