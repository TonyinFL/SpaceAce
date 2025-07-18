class_name GameUI extends Control

@onready var health_bar: HealthBar = $ColorRect/MarginContainer/HealthBar
@onready var sound: AudioStreamPlayer2D = $Sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_player_hit.connect(on_player_hit)
	SignalHub.on_player_health_bonus.connect(on_player_health_bonus)


func on_player_hit(damage: int) -> void:
	health_bar.take_damage(damage)


func on_player_health_bonus(bonus: int) -> void:
	health_bar.add_health(bonus)
	sound.play()

func _on_health_bar_died() -> void:
	print ("Player died!")
