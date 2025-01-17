extends CharacterBody2D

@onready var damage_number_origin = $DamageNumbersOrigin
@onready var animated_player = $AnimationPlayer

# take damage function
# - play the hit flash animation
# - display the damage number, display dmg number have 2 parameters
# 1. total damage
# 2. damage number origin global position
func take_damage(total_damage: float) -> void:
	print("Take Damage ", total_damage)
	animated_player.play("hit_flash")
	DamageNumbers.display_damage_number(total_damage, damage_number_origin.global_position)
