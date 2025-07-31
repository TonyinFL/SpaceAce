class_name EnemyBase extends PathFollow2D

@export var score_points: int = 10
@export var crash_damage: int = 10

@onready var explosion_points: Node2D = $ExplosionPoints
@onready var health_bar: HealthBar = $HealthBar
@onready var sound: AudioStreamPlayer2D = $Sound

var _speed: float = 50  # Pixels per second


func _ready() -> void:
	health_bar.health_bar_died.connect(on_health_bar_died)


func _process(delta: float) -> void:
	progress += _speed * delta
	if progress_ratio > .99:
		queue_free()


func make_explosions() -> void:
	for explosion_point:Marker2D in explosion_points.get_children():
		SignalHub.emit_create_explosion(
			Explosion.EXPLOSION_BIG,
			explosion_point.global_position 
		)


func die() -> void:
	# For timing purposes, make_explosions() for Saucer is directly
	# invoked from AnimationPlayer.
	if self is not Saucer:
		make_explosions()
	queue_free()


func on_health_bar_died() -> void:
	ScoreManager.add_to_score(score_points)
	die()


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area is BulletBase:
		health_bar.take_damage(area.get_damage())
