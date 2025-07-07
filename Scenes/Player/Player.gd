class_name Player extends Area2D

const GROUP_NAME: String = "Player"

@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	pass


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


func _process(_delta: float) -> void:
	pass
