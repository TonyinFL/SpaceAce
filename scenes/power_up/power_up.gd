class_name PowerUp extends Projectile

enum PowerUpType {Health, Shield}

const TEXTURES: Dictionary = {
	PowerUpType.Health: preload("res://assets/misc/green_bolt.png"),
	PowerUpType.Shield: preload("res://assets/misc/shield_gold.png"),
}

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var speed: float = 80.0

var _power_up_type: PowerUpType = PowerUpType.Shield


func _ready() -> void:
	sprite_2d.texture = TEXTURES[_power_up_type] 


func setup(power_up_type: PowerUp.PowerUpType) -> void:
	_power_up_type = power_up_type


func _process(delta: float) -> void:
	position.y += speed * delta * Vector2.DOWN.y
