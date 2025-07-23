class_name EnemyShip extends EnemyBase

const DEFAULT_BULLET_DIRECTION: Vector2 = Vector2.DOWN

@export var shoots_at_player: bool = false
@export var aims_at_player: bool = false
@export var bullet_type: BulletBase.BulletType = BulletBase.BulletType.Enemy
@export var bullet_speed: float = 120.0
@export var bullet_direction: Vector2 = DEFAULT_BULLET_DIRECTION
@export var bullet_wait_time: float = 3.0
@export var bullet_wait_time_var: float = 0.5
@export var power_up_chance: float = 0.9

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shoot_timer: Timer = $ShootTimer

var _player: Player


func _ready() -> void:
	_player = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if !_player:
		queue_free()
	SpaceUtils.play_random_animation(animated_sprite_2d)
	start_shoot_timer()


func die() -> void:
	create_power_up()
	super.die()


func create_power_up() -> void:
	if randf() <= power_up_chance:
		SignalHub.emit_on_create_random_power_up(global_position)


func start_shoot_timer() -> void:
	SpaceUtils.set_and_start_timer(shoot_timer, bullet_wait_time, bullet_wait_time_var)


func _on_shoot_timer_timeout() -> void:
	shoot()


# Note the timer stays active as long as the player reference exists.  
# Both shooting and aiming can be turned on/off dynamically
# via shoots_at_player and aims_at_player, respectively.
func shoot() -> void:
	if not _player:
		return
	if shoots_at_player:
		update_bullet_direction()
		SignalHub.emit_on_create_bullet(bullet_type, global_position, bullet_direction, bullet_speed)
	start_shoot_timer()


func update_bullet_direction() -> void:
	if aims_at_player:
		bullet_direction = global_position.direction_to(_player.global_position)
	else:
		bullet_direction = DEFAULT_BULLET_DIRECTION
