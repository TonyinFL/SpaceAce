class_name Explosion extends Node2D

const BOOM: String = "boom"
const EXPLODE: String = "explode"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var _animation_name: String = BOOM

func _ready() -> void:
	animated_sprite_2d.animation = _animation_name
	animated_sprite_2d.play()

func setup(animation_name: String) -> void:
	_animation_name = animation_name

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
