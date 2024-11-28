extends Node

@onready var progress_bar = $"../UI/ProgressBar"
@onready var hurtbox = $"../HurtboxComponent/CollisionShape2D"

var DEF = 0
@export var health = 20:
	set(value):
		health = value
		progress_bar.value = value
		print(health)
		if value <= 0:
			progress_bar.visible = false
			hurtbox.call_deferred("set_disabled", true)
			owner.find_child("EnemyStateMachine").change_state("Death")
		elif value <= progress_bar.max_value / 2 and DEF == 0:
			DEF = 5
