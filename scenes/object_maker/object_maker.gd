class_name ObjectMaker extends Node2D

const ADD_OBJECT: String = "add_object"
const EXPLOSION: PackedScene = preload("res://scenes/explosion/explosion.tscn")
const POWER_UP: PackedScene = preload("res://scenes/power_up/power_up.tscn")


func _ready() -> void:
	SignalHub.on_create_explosion.connect(on_create_explosion)
	SignalHub.on_create_power_up.connect(on_create_power_up)
	SignalHub.on_create_random_power_up.connect(on_create_random_power_up)


func add_object(object: Node, spawn_position: Vector2) -> void:
	object.global_position = spawn_position
	add_child(object)


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
