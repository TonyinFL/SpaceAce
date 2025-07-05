extends Node2D

@onready var player: Player = $Player

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		SignalHub.emit_on_create_explosion(
			Explosion.BOOM, 
			player.global_position - Vector2(-100.0, +100.0))
		SignalHub.emit_on_create_explosion(
			Explosion.EXPLODE, 
			player.global_position - Vector2(+100.0, +100.0))
