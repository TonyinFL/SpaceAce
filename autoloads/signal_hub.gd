extends Node

signal on_player_hit(damage: int)
signal on_score_updated(score: int)
signal on_create_explosion(animation_name: String, spawn_position: Vector2)


func emit_on_player_hit(damage: int) -> void:
	on_player_hit.emit(damage)


func emit_on_score_updated(score: int) -> void:
	on_score_updated.emit(score)


func emit_on_create_explosion(animation_name: String, spawn_position: Vector2) -> void:
	on_create_explosion.emit(animation_name, spawn_position)
