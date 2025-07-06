extends Node2D

@onready var player: Player = $Player


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		SignalHub.emit_on_create_power_up(
			PowerUp.PowerUpType.Health, 
			player.global_position + Vector2(+100.0, -300.0))
		SignalHub.emit_on_create_power_up(
			PowerUp.PowerUpType.Shield, 
			player.global_position + Vector2(-100.0, -300.0))
		SignalHub.emit_on_create_random_power_up(
			player.global_position + Vector2(0.0, -300.0))
