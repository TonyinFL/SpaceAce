class_name UIButton extends TextureButton


@onready var label: Label = $Label

@export var button_text: String = "Text"


func _ready() -> void:
	label.text = button_text
