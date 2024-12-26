extends Node

# Health Component
# This script is used to manage the health of the enemy

# UPDATE SOON: HEALTH COMPONENT CAN APPLY TO ALL ENTITY (PLAYER, ENEMY)

# Component Properties
# UI HealthBar
@onready var health_bar = $"../UIComponents/HealthBar"
# Hurtbox Component
@onready var hurtbox = $"../HurtboxComponent/CollisionShape2D"

var DEF = 0
# Health Value
# This value is used to store the health
# Default value is 500 (Debugging = 20)
@export var health: int = 100:
	set(value):
		health = value
		health_bar.value = value
		print(str(health) + " ", owner.name)
		# Check if health is less than or equal to 0
		# call the set_off_health_component function
		# Check if health is less than or equal to half of the max value
		# Set the DEF to 5
		if value <= 0:
			owner.set_off_health_component()
		elif value <= health_bar.max_value / 2 and DEF == 0:
			owner.increase_defense()
