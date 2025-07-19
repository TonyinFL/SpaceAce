class_name Player extends Area2D

const GROUP_NAME: String = "Player"
const SPEED: float = 250.0 # pixels per second


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shield: Shield = $Shield
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _screen_size: Vector2
var _sprite_width: float
var _sprite_height: float


func _ready() -> void:
	_screen_size = get_viewport().get_visible_rect().size
	_sprite_width = sprite_2d.texture.get_width() * sprite_2d.scale.x
	_sprite_height = sprite_2d.texture.get_height() * sprite_2d.scale.y


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


func _process(delta: float) -> void:
	position += get_input() * SPEED * delta	
	position.x = clamp(position.x, _sprite_width/2, _screen_size.x - _sprite_width/2)
	position.y = clamp(position.y, _sprite_height/2, _screen_size.y - _sprite_height/2)
	
	if Input.is_action_just_pressed("shoot"):
		SignalHub.emit_on_create_bullet(BulletBase.BulletType.Player,
			global_position, 
			Vector2.UP, 
			BulletPlayer.SPEED
		)

func get_input() -> Vector2:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	# Note: You can build a Vector2 using two normalized Input.get_axis calls,
	# like Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).
	# However, get_vector() automatically normalizes the result and applies
	# a deadzone to filter small analog joystick noise.
	
	if not is_zero_approx(direction.x):
		animation_player.play("turn")
		sprite_2d.flip_h = direction.x > 0
	else:
		animation_player.play("fly")
		
	return direction
		


func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		match area.get_power_up_type():
			PowerUp.PowerUpType.Shield:
				shield.enable_shield(PowerUp.SHIELD_DURATION)
			PowerUp.PowerUpType.Health:
				SignalHub.emit_on_player_health_bonus(PowerUp.HEALTH_BONUS)
	elif area is Projectile:
		SignalHub.emit_on_player_hit(area.get_damage())
