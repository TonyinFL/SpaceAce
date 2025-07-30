class_name GameOverUI extends Control

@onready var current_score_label: Label = $ColorRect/VBoxContainer/CurrentScoreLabel
@onready var high_score_label: Label = $ColorRect/VBoxContainer/HighScoreLabel
@onready var continue_label: Label = $ColorRect/VBoxContainer/ContinueLabel

@export var wait_time: float = 2.0

var _player_can_shoot: bool = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		GameManager.load_main_scene()
	if _player_can_shoot and event.is_action_pressed("shoot"):
		GameManager.load_main_scene()
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused


func _ready() -> void:
	current_score_label.text = ""
	high_score_label.text = ""
	continue_label.text = ""
	# Set process_mode in code for clarity; can also be configured via the Inspector.
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	get_tree().paused = false
	SignalHub.on_player_died.connect(on_player_died)


func on_player_died() -> void:
	get_tree().paused = true
	show()
	await get_tree().create_timer(wait_time).timeout
	
	_player_can_shoot = true
	current_score_label.text = "Current Score: %06d" % [ScoreManager.score]
	high_score_label.text = "High Score: %06d" % [ScoreManager.high_score]
	continue_label.text = "Press Fire To Continue"
