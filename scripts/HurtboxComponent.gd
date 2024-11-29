extends Area2D
class_name HurtboxComponent

func _init() -> void:
	pass

func _ready() -> void:
	# connect to area_entered signal
	connect("area_entered", Callable(self, "_on_area_entered"))

# on area entered, check if hitbox is null, if not null, take damage
func _on_area_entered(hitbox: HitboxComponent) -> void:
	if hitbox == null:
		print("Hitbox is null")
	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
	
