class_name Player extends Area2D

# TODO Add player ship explosion upon player death and don't stop the game until the
#      explosion animation completes.

const GROUP_NAME: String = "Player"
const PLAYER_SPEED: float = 250.0  # Pixels per second
const BULLET_SPEED: float = 300.0  # Pixels per second
const BULLET_DIRECTION: Vector2 = Vector2.UP

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shield: Shield = $Shield
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _viewport: Rect2 
var _upper_left: Vector2
var _lower_right: Vector2
var _margin: Vector2


func _ready() -> void:
	set_limits()


func set_limits() -> void:
	_margin = sprite_2d.get_rect().size * sprite_2d.scale * .5
	_viewport = get_viewport_rect()
	_lower_right = Vector2(_viewport.end.x - _margin.x, _viewport.end.y - _margin.y)
	_upper_left = Vector2(_margin.x, _margin.y)  # Assumes viewport starts at 0,0


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


func _process(delta: float) -> void:
	global_position += get_input() * PLAYER_SPEED * delta
	global_position = global_position.clamp(_upper_left, _lower_right)
	
	
	if Input.is_action_just_pressed("shoot"):
		shoot()


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
		

func shoot() -> void:
	SignalHub.emit_create_bullet(
		BulletBase.BulletType.Player,
		global_position, 
		BULLET_DIRECTION,
		BULLET_SPEED
	)


func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		match area.get_power_up_type():
			PowerUp.PowerUpType.Shield:
				shield.enable_shield(PowerUp.SHIELD_DURATION)
			PowerUp.PowerUpType.Health:
				SignalHub.emit_player_health_bonus(PowerUp.HEALTH_BONUS)
	elif area is Projectile:
		SignalHub.emit_player_hit(area.damage)
	# Consider using a class_name (e.g., EnemyHitBox) or an enum/type field on the HitBox
	# to identify it directly, instead of checking the parent node type.
	elif area.get_parent() is EnemyBase:
		SignalHub.emit_player_hit(area.get_parent().crash_damage)
