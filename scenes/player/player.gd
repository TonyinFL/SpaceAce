class_name Player extends Area2D

const GROUP_NAME: String = "Player"

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shield: Shield = $Shield


func _ready() -> void:
	pass


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


func _process(delta: float) -> void:

	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	position += direction * 400.0 * delta		


func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		if area.get_power_up_type() == PowerUp.PowerUpType.Shield:
			shield.enable_shield()
