extends Area2D
class_name HurtboxComponent

func _init() -> void:
	collision_layer = 0
	collision_mask = 1


func _ready() -> void:
	connect("area_entered", Callable(self, "_on_area_entered"))

func _on_area_entered(hitbox: HitboxComponent) -> void:
	if hitbox == null:
		print("Hitbox is null")
	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
	