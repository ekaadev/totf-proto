extends Node

# Health Component
# This script is used to manage the health of the enemy

# UPDATE SOON: HEALTH COMPONENT CAN APPLY TO ALL ENTITY (PLAYER, ENEMY)

# Component Properties

# UI HealthBar
# @onready var health_bar = $"../UIComponents/HealthBar"
@onready var health_bar_player = $"../HUDAvatarPlayer/MarginContainer/HBoxContainer/VBoxContainer/TextureRect/HealthBar" if owner.name == "Player" else null
# Hurtbox Component
@onready var hurtbox = $"../HurtboxComponent/CollisionShape2D"

@export var entity_max_health: int = 100

var DEF = 0
# Health Value
# This value is used to store the health
# Default value is 500 (Debugging = 20)
@export var health: int = 100:
	set(value):
		health = value
		
		# health_bar.value = value

		if health_bar_player:
			health_bar_player.value = value

		# print(str(health) + " ", owner.name)
		
		# Check if health is less than or equal to 0
		# call the set_off_health_component functions
		# Check if health is less than or equal to half of the max value
		# Set the DEF to 5

		if value <= 0:
			owner.set_off_health_component()
		elif value <= float(entity_max_health) / 2 and DEF == 0:
			if (owner.has_method("increase_defense")):
				owner.increase_defense()
