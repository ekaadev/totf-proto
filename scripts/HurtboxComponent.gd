extends Area2D
class_name HurtboxComponent

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(hitbox: HitboxComponent) -> void:
	if hitbox == null:
		return
	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)