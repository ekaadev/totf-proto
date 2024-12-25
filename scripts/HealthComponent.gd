extends Node

# Health Component
# This script is used to manage the health of the enemy

# UPDATE SOON: HEALTH COMPONENT CAN APPLY TO ALL ENTITY (PLAYER, ENEMY)

# Component Properties
# UI ProgressBar
@onready var progress_bar = $"../UI/ProgressBar"
# Hurtbox Component
@onready var hurtbox = $"../HurtboxComponent/CollisionShape2D"

var DEF = 0
# Health Value
# This value is used to store the health
# Default value is 500 (Debugging = 20)
@export var health = 100:
	set(value):
		health = value
		progress_bar.value = value
		print(health)
		# Check if health is less than or equal to 0
		# Set the progress bar to invisible
		# Set the hurtbox to disabled
		# Change the state to Death
		# Check if health is less than or equal to half of the max value
		# Set the DEF to 5
		if value <= 0:
			progress_bar.visible = false
			hurtbox.call_deferred("set_disabled", true)
			owner.find_child("EnemyStateMachine").change_state("Death")
		elif value <= progress_bar.max_value / 2 and DEF == 0:
			DEF = 5
