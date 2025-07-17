class_name GameUI extends Control

@onready var health_bar: HealthBar = $ColorRect/MarginContainer/HealthBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_player_hit.connect(on_player_hit)


func on_player_hit(damage: int) -> void:
	health_bar.take_damage(damage)


func _on_health_bar_died() -> void:
	print ("Player died!")
