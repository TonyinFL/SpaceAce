class_name Explosion extends Node2D

const EXPLOSION_SMALL: String = "explosion_small"
const EXPLOSION_BIG: String = "explosion_big"
const EXPLOSION_SOUND_SMALL: AudioStream = preload("res://assets/sounds/explosions/explosion_01.wav")
const EXPLOSION_SOUND_BIG: AudioStream = preload("res://assets/sounds/explosions/explosion_05.wav")

@onready var sound: AudioStreamPlayer = $Sound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var _animation_name: String = EXPLOSION_SMALL


func _ready() -> void:
	animated_sprite_2d.animation = _animation_name
	animated_sprite_2d.play()
	match _animation_name:
		EXPLOSION_SMALL:
			sound.stream = EXPLOSION_SOUND_SMALL
		EXPLOSION_BIG:
			sound.stream = EXPLOSION_SOUND_BIG
		_:
			sound.stream = EXPLOSION_SOUND_SMALL  # Default sound
	sound.play()


func setup(animation_name: String) -> void:
	_animation_name = animation_name


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
