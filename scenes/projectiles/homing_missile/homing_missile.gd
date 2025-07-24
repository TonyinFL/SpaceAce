class_name HomingMissle extends Projectile

const ROTATION_SPEED: float = 1.2
const MOVEMENT_SPEED: float = 40.0
const POINTS: int = 5

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
	

func blow_up() -> void:
	ScoreManager.add_to_score(POINTS)
	SignalHub.emit_on_create_explosion(Explosion.BOOM, global_position)
	super()
