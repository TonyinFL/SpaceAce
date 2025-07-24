class_name ObjectMaker extends Node2D

const ADD_OBJECT: String = "add_object"
const EXPLOSION: PackedScene = preload("res://scenes/explosions/explosion.tscn")
const POWER_UP: PackedScene = preload("res://scenes/projectiles/power_ups/power_up.tscn")
const BULLET_PLAYER: PackedScene = preload("res://scenes/projectiles/bullets/bullet_player.tscn")
const BULLET_ENEMY: PackedScene = preload("res://scenes/projectiles/bullets/bullet_enemy.tscn")
const BULLET_BOMB: PackedScene = preload("res://scenes/projectiles/bullets/bullet_bomb.tscn")
const HOMING_MISSILE: PackedScene = preload("res://scenes/projectiles/homing_missile/homing_missile.tscn")

func _ready() -> void:
	SignalHub.on_create_explosion.connect(on_create_explosion)
	SignalHub.on_create_power_up.connect(on_create_power_up)
	SignalHub.on_create_random_power_up.connect(on_create_random_power_up)
	SignalHub.on_create_bullet.connect(on_create_bullet)
	SignalHub.on_create_homing_missile.connect(on_create_homing_missile)


func add_object(object: Node, spawn_position: Vector2) -> void:
	object.global_position = spawn_position
	add_child(object)


func on_create_bullet(bullet_type: BulletBase.BulletType, spawn_position: Vector2,
		direction: Vector2, speed: float) -> void:
	var bullet: BulletBase
	match bullet_type:
		BulletBase.BulletType.Player:
			bullet = BULLET_PLAYER.instantiate()
		BulletBase.BulletType.Enemy:
			bullet = BULLET_ENEMY.instantiate()
		BulletBase.BulletType.Bomb:
			bullet = BULLET_BOMB.instantiate()
		_:
			printerr("Unknown bullet type!")
			return
	if bullet:
		bullet.setup(direction, speed)
		call_deferred(ADD_OBJECT, bullet, spawn_position)


func on_create_explosion(animation_name: String, spawn_position: Vector2) -> void:
	var explosion: Explosion = EXPLOSION.instantiate()
	explosion.setup(animation_name)
	call_deferred(ADD_OBJECT, explosion, spawn_position)


func on_create_power_up(power_up_type: PowerUp.PowerUpType, spawn_position: Vector2) -> void:
	var power_up: PowerUp = POWER_UP.instantiate()
	power_up.setup(power_up_type)
	call_deferred(ADD_OBJECT, power_up, spawn_position)


func on_create_random_power_up(spawn_position: Vector2) -> void:
	var power_up_type:PowerUp.PowerUpType = PowerUp.PowerUpType.values().pick_random()
	on_create_power_up(power_up_type, spawn_position)


func on_create_homing_missile(spawn_position: Vector2) -> void:
	var homing_missle: HomingMissle = HOMING_MISSILE.instantiate()
	call_deferred(ADD_OBJECT, homing_missle, spawn_position)
