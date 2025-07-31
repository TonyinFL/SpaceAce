class_name HomingMissle extends Projectile

const ROTATION_SPEED: float = 1.2
const MOVEMENT_SPEED: float = 40.0
const SCORE_POINTS: int = 5

@onready var health_bar: HealthBar = $HealthBar

var _player: Player


func _ready() -> void:
	health_bar.health_bar_died.connect(on_health_bar_died)
	_player = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if not _player:
		queue_free()


func _process(delta: float) -> void:
	var direction_to_player: Vector2 = global_position.direction_to(_player.global_position)
	var angle_to_player: float = transform.x.angle_to(direction_to_player)
	
	rotate(sign(angle_to_player) * min(abs(angle_to_player), ROTATION_SPEED * delta))
	position += transform.x * MOVEMENT_SPEED * delta


func blow_up() -> void:
	const OFFSET: Vector2 = Vector2(0, 15)
	SignalHub.emit_create_explosion(Explosion.EXPLOSION_BIG, global_position)
	SignalHub.emit_create_explosion(Explosion.EXPLOSION_BIG, global_position - OFFSET)
	SignalHub.emit_create_explosion(Explosion.EXPLOSION_BIG, global_position + OFFSET)
	super()


func _on_area_entered(area: Area2D) -> void:
	if area is BulletBase:
		health_bar.take_damage(area.damage)
	elif area is Player or area is Shield:
		blow_up()


func on_health_bar_died() -> void:
	ScoreManager.add_to_score(SCORE_POINTS)
	blow_up()
