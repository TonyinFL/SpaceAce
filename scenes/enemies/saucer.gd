class_name Saucer extends EnemyBase

@onready var shoot_timer: Timer = $ShootTimer
@onready var hit_box: Area2D = $HitBox

var is_shooting: bool = false
var is_dead: bool = false


func _process(delta: float) -> void:
	if not is_shooting:
		super(delta)


func set_shooting(shooting: bool) -> void:
	is_shooting = shooting


func fire_homing_missle() -> void:
	SignalHub.emit_on_create_homing_missile(global_position)


func _on_shoot_timer_timeout() -> void:
	set_shooting(true)


func _on_health_bar_died() -> void:
	is_dead = true
	shoot_timer.stop()
	set_process(false)
	SpaceUtils.toggle_area2d(hit_box, false)
	ScoreManager.add_to_score(score_points)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die":
		die()
