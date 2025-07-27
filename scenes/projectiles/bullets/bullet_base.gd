class_name  BulletBase extends Projectile

enum BulletType {Player, Enemy, Bomb}

var _direction: Vector2 = Vector2.UP
var _speed: float = 50


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	position += _speed * _direction * delta


func setup(direction: Vector2, speed: float) -> void:
	_direction = direction
	_speed = speed
	

func blow_up() -> void:
	SignalHub.emit_on_create_explosion(Explosion.EXPLOSION_SMALL, global_position)
	super()
