class_name Main extends Control

@onready var play_button: TextureButton = $MC/VB/PlayButton
@onready var exit_button: TextureButton = $MC/VB/ExitButton


func _ready() -> void:
	# Set process_mode in code for clarity; can also be configured via the Inspector.
	process_mode = Node.PROCESS_MODE_ALWAYS


func _on_play_button_pressed() -> void:
	GameManager.load_level_scene()


func _on_exit_button_pressed() -> void:
	GameManager.exit_game()
