class_name HomingMissle extends Projectile

const ROTATION_SPEED: float = 1.2
const MOVEMENT_SPEED: float = 40.0
const SCORE_POINTS: int = 5

@onready var health_bar: HealthBar = $HealthBar

var _player: Player


func _ready() -> void:
	_player = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if not _player:
		queue_free()
	

func _process(delta: float) -> void:
	var direction_to_player: Vector2 = global_position.direction_to(_player.global_position)
	var angle_to_player: float = transform.x.angle_to(direction_to_player)
	
	rotate(sign(angle_to_player) * min(abs(angle_to_player), ROTATION_SPEED * delta))
	position += transform.x * MOVEMENT_SPEED * delta


# TODO Use larger explosion when missle is destroyed and shake screen.
# TODO Update explosion names to EXPLOSION_BIG and EXPLOSION_SMALL along with
#      corresponding audio names.


func blow_up() -> void:
	ScoreManager.add_to_score(SCORE_POINTS)
	SignalHub.emit_on_create_explosion(Explosion.BOOM, global_position)
	super()


func _on_area_entered(area: Area2D) -> void:
	if area is BulletBase:
		health_bar.take_damage(area.get_damage())
	elif area is Player or area is Shield:
		blow_up()
		

func _on_health_bar_died() -> void:
	blow_up()
