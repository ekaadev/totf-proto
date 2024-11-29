extends Node

@onready var progress_bar = $"../UIPlayer/HealthBar"
@onready var hurtbox = $"../HurtboxComponent/CollisionShape2D"

@export var health = 100:
	set(value):
		health = value
		progress_bar.value = value
		print(health)
		if value <= 0:
			# health = 100
			# progress_bar.value = health
			hurtbox.call_deferred("set_disabled", true)
			owner.find_child("StateMachine").transition_to("Death")
