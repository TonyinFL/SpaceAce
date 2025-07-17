class_name HealthBar extends TextureProgressBar

signal died


@export var start_health: int = 100
@export var max_health: int = 100

const LOW_HEALTH_COLOR: Color = Color.RED
const MEDIUM_HEALTH_COLOR: Color = Color.ORANGE
const HIGH_HEALTH_COLOR: Color = Color.GREEN


func _ready() -> void:
	max_value = max_health
	value = start_health
	set_color()
	

func set_color() -> void:
	var percent: float = value / max_health
	
	#tint_progress = LOW_HEALTH_COLOR.lerp(HIGH_HEALTH_COLOR, percent)
	
	if percent <= 1.0 / 3.0:
		tint_progress = LOW_HEALTH_COLOR
	elif percent <= 2.0 / 3.0:
		tint_progress = MEDIUM_HEALTH_COLOR
	else:
		tint_progress = HIGH_HEALTH_COLOR


func change_value(v: int) -> void:
	value += v
	if value <= 0:
		died.emit()
	set_color()


func add_health(v: int) -> void:
	change_value(v)


func take_damage(v: int) -> void:
	change_value(-v)
	
