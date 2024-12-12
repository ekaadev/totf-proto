extends Node

@onready var hurtbox = $"../HurtboxComponent/CollisionShape2D"

@export var maxHealth = 10
var currentHealth = maxHealth

func getHealth():
	return currentHealth

func setHealth(value):
	currentHealth = min(value, maxHealth)
	print(currentHealth)
	
	if value <= 0:
		hurtbox.call_deferred("set_disabled", true)
		owner.find_child("EnemyStateMachine").change_state("Death")
