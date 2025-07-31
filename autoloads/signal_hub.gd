extends Node

signal player_hit(damage: int)
signal player_health_bonus(bonus: int)
signal player_died
signal score_updated(score: int)
signal create_explosion(animation_name: String, spawn_position: Vector2)
signal create_power_up(power_up_type: PowerUp.PowerUpType, spawn_position: Vector2)
signal create_random_power_up(spawn_position: Vector2)
signal create_bullet(bullet_type: BulletBase.BulletType, spawn_position: Vector2,
		direction: Vector2, speed: float)
signal create_homing_missile(spawn_position: Vector2)


func emit_player_hit(damage: int) -> void:
	player_hit.emit(damage)


func emit_player_health_bonus(bonus: int) -> void:
	player_health_bonus.emit(bonus)


func emit_player_died() -> void:
	player_died.emit()


func emit_score_updated(score: int) -> void:
	score_updated.emit(score)


func emit_create_explosion(animation_name: String, spawn_position: Vector2) -> void:
	create_explosion.emit(animation_name, spawn_position)


func emit_create_power_up(power_up_type: PowerUp.PowerUpType, spawn_position: Vector2) -> void:
	create_power_up.emit(power_up_type, spawn_position)


func emit_create_random_power_up(spawn_position: Vector2) -> void:
	create_random_power_up.emit(spawn_position)
	
	
func emit_create_bullet(bullet_type: BulletBase.BulletType, spawn_position: Vector2,
		direction: Vector2, speed: float) -> void:
	create_bullet.emit(bullet_type, spawn_position, direction, speed)


func emit_create_homing_missile(spawn_position: Vector2) -> void:
	create_homing_missile.emit(spawn_position)
