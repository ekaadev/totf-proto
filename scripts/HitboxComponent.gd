extends Area2D
class_name HitboxComponent

signal hit(damage)

@export var damage: int = 10

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage)
		emit_signal("hit", damage)