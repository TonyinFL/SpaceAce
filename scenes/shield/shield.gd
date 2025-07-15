class_name Shield extends Area2D

@export var start_health: int = 5

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _health: int = start_health


func _ready() -> void:
	disable_shield()


func disable_shield() -> void:
	timer.stop()
	SpaceUtils.toggle_area2d(self, false)
	hide()


func enable_shield() -> void:
	animation_player.play("RESET")
	_health = start_health
	timer.start()
	SpaceUtils.toggle_area2d(self, true)
	sound.play()
	show()
	
	
func hit() -> void:
	animation_player.play("hit")
	_health -= 1
	if _health <= 0:
		disable_shield()


func _on_area_entered(_area: Area2D) -> void:
	hit()


func _on_timer_timeout() -> void:
	disable_shield()
