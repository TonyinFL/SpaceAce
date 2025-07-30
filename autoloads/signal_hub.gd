extends Node

# TODO: Rename signals to remove the "on_" prefix.
#       Reserve "on_*" naming for the *handler functions* that respond to these signals.

signal on_player_hit(damage: int)
signal on_player_health_bonus(bonus: int)
signal on_player_died
signal on_score_updated(score: int)
signal on_create_explosion(animation_name: String, spawn_position: Vector2)
signal on_create_power_up(power_up_type: PowerUp.PowerUpType, spawn_position: Vector2)
signal on_create_random_power_up(spawn_position: Vector2)
signal on_create_bullet(bullet_type: BulletBase.BulletType, spawn_position: Vector2,
		direction: Vector2, speed: float)
signal on_create_homing_missile(spawn_position: Vector2)


func emit_on_player_hit(damage: int) -> void:
	on_player_hit.emit(damage)


func emit_on_player_health_bonus(bonus: int) -> void:
	on_player_health_bonus.emit(bonus)


func emit_on_player_died() -> void:
	on_player_died.emit()


func emit_on_score_updated(score: int) -> void:
	on_score_updated.emit(score)


func emit_on_create_explosion(animation_name: String, spawn_position: Vector2) -> void:
	on_create_explosion.emit(animation_name, spawn_position)


func emit_on_create_power_up(power_up_type: PowerUp.PowerUpType, spawn_position: Vector2) -> void:
	on_create_power_up.emit(power_up_type, spawn_position)


func emit_on_create_random_power_up(spawn_position: Vector2) -> void:
	on_create_random_power_up.emit(spawn_position)
	
	
func emit_on_create_bullet(bullet_type: BulletBase.BulletType, spawn_position: Vector2,
		direction: Vector2, speed: float) -> void:
	on_create_bullet.emit(bullet_type, spawn_position, direction, speed)


func emit_on_create_homing_missile(spawn_position: Vector2) -> void:
	on_create_homing_missile.emit(spawn_position)
