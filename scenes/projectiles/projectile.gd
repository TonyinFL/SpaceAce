class_name Projectile extends Area2D

@export var damage: int = 10


func blow_up() -> void:
	set_process(false)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	blow_up()


func _on_area_entered(_area: Area2D) -> void:
	blow_up()
