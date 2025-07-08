extends Node2D

@onready var player: Player = $Player


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		SignalHub.emit_on_create_bullet(
			BulletBase.BulletType.Player, 
			player.global_position + Vector2(0, -225),
			get_random_upward_vector(),
			-150.0)
		SignalHub.emit_on_create_bullet(
			BulletBase.BulletType.Enemy, 
			player.global_position + Vector2(0, -225),
			get_random_upward_vector(),
			-150.0)
		SignalHub.emit_on_create_bullet(
			BulletBase.BulletType.Bomb, 
			player.global_position + Vector2(0, -225),
			get_random_upward_vector(),
			-100.0)


func get_random_upward_vector() -> Vector2:
	var spread_degrees: float = 15
	var base_angle: float = -90.0 # straight up in degrees
	var random_angle: float = deg_to_rad(base_angle + randf_range(-spread_degrees / 2.0, spread_degrees / 2.0))
	return Vector2.RIGHT.rotated(random_angle).normalized()
