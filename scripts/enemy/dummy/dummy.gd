extends CharacterBody2D

@onready var damage_number_origin = $DamageNumbersOrigin

func take_damage(total_damage: float) -> void:
	print("Take Damage ", total_damage)
	DamageNumbers.display_damage_number(total_damage, damage_number_origin.global_position)
	
