class_name ObjectMaker extends Node2D

const ADD_OBJECT: String = "add_object"
const EXPLOSION: PackedScene = preload("res://scenes/explosion/explosion.tscn")


func _ready() -> void:
	SignalHub.on_create_explosion.connect(on_create_explosion)


func add_object(object: Node, spawn_position: Vector2) -> void:
	object.global_position = spawn_position
	add_child(object)


func on_create_explosion(animation_name: String, spawn_position: Vector2) -> void:
	var explosion: Explosion = EXPLOSION.instantiate()
	explosion.setup(animation_name)
	call_deferred(ADD_OBJECT, explosion, spawn_position)
