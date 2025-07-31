extends Node2D

@onready var player: Player = $Player


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		SignalHub.emit_create_power_up(
			PowerUp.PowerUpType.Shield, 
			player.global_position + Vector2(0, -350))
