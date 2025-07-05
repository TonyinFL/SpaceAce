class_name LifeTimer extends Node

@export var life_seconds: float = 15.0


func _ready() -> void:
	await get_tree().create_timer(life_seconds).timeout
	get_parent().queue_free()
