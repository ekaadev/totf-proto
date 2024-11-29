extends Node

# Health Player Component
# This script is used to manage the health of the player

# UPDATE SOON: HEALTH COMPONENT CAN APPLY TO ALL ENTITY (PLAYER, ENEMY)

# Component Properties
# UI ProgressBar
@onready var progress_bar = $"../UIPlayer/HealthBar"
# Hurtbox Component
@onready var hurtbox = $"../HurtboxComponent/CollisionShape2D"

# Health Value
# This value is used to store the health
# Default value is 100 (Debugging = 100)
@export var health = 100:
	set(value):
		health = value
		progress_bar.value = value
		print(health)
		# Check if health is less than or equal to 0
		# Set the progress bar to invisible
		# Set the hurtbox to disabled
		if value <= 0:
			hurtbox.call_deferred("set_disabled", true)
			owner.find_child("StateMachine").transition_to("Death")
