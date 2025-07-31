class_name Shield extends Area2D

@export var start_health: int = 50

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var debug_label: Label = $DebugLabel

var _health: int = start_health


func _ready() -> void:
	disable_shield()


func _process(_delta: float) -> void:
	# Debug: Show shield health and remaining time.
	if not timer.is_stopped():
		debug_label.text = "Shield: %d\nTime: %.1f" % [_health, timer.time_left]

func disable_shield() -> void:
	timer.stop()
	SpaceUtils.toggle_area2d(self, false)
	hide()


func enable_shield(time: float) -> void:
	if timer.is_stopped():
		_health = start_health  # New shield, so reset health
		animation_player.play("RESET")
		timer.start(time)
		SpaceUtils.toggle_area2d(self, true)
		show()
	else: # shield already active
		_health += start_health  # stack health
		timer.start(timer.time_left + time)  # extend duration
	
	sound.play()
	
	
func hit(damage: int) -> void:
	animation_player.play("hit")
	_health -= damage
	if _health <= 0:
		disable_shield()


func _on_area_entered(area: Area2D) -> void:
	var damage: int = 0
	if area is Projectile:
		damage = area.damage
	elif area.get_parent() is EnemyBase:
		damage = area.get_parent().crash_damage
	else:
		return
	hit(damage)


func _on_timer_timeout() -> void:
	disable_shield()
