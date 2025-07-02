extends Node

signal on_player_hit(damage: int)
signal on_score_updated(score: int)


func emit_on_player_hit(damage: int) -> void:
	on_player_hit.emit(damage)


func emit_on_score_updated(score: int) -> void:
	on_score_updated.emit(score)
