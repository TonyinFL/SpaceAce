class_name GameUI extends Control

@onready var health_bar: HealthBar = $ColorRect/MarginContainer/HealthBar
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var score_label: Label = $ColorRect/MarginContainer/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.health_bar_died.connect(on_health_bar_died)
	ScoreManager.reset_score()
	SignalHub.player_hit.connect(on_player_hit)
	SignalHub.player_health_bonus.connect(on_player_health_bonus)
	SignalHub.score_updated.connect(on_score_updated)


func on_player_hit(damage: int) -> void:
	health_bar.take_damage(damage)


func on_player_health_bonus(bonus: int) -> void:
	health_bar.add_health(bonus)
	sound.play()


func on_score_updated(score: int) -> void:
	score_label.text = "%06d" % score


func on_health_bar_died() -> void:
	SignalHub.emit_player_died()
