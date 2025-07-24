class_name Explosion extends Node2D

const BOOM: String = "boom"
const EXPLODE: String = "explode"
const EXPLOSION_01: AudioStream = preload("res://assets/sounds/explosions/explosion_01.wav")
const EXPLOSION_05: AudioStream = preload("res://assets/sounds/explosions/explosion_05.wav")

@onready var sound: AudioStreamPlayer = $Sound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var _animation_name: String = BOOM

func _ready() -> void:
	animated_sprite_2d.animation = _animation_name
	animated_sprite_2d.play()
	match _animation_name:
		BOOM:
			sound.stream = EXPLOSION_01
		EXPLODE:
			sound.stream = EXPLOSION_05
		_:
			sound.stream = EXPLOSION_01  # Default sound
	sound.play()
	

func setup(animation_name: String) -> void:
	_animation_name = animation_name

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
