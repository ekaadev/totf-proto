extends Area2D
class_name HitboxComponent

# damage from hitbox
@export var damage: int = 0
var damage_multiplier: float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():

	# Setting the damage multiplier based on the owner entity's level
	var owner_entity = owner
	if owner_entity.has_method("get_current_level"):
		damage_multiplier = 1 + owner_entity.get_current_level()
	else:
		print("Owner entity does not have get_current_level method")
