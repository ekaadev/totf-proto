extends Node

@onready var hurtbox = $"../HurtboxComponent/CollisionShape2D"

@export var maxHealth := 10 :
	set(val):
		maxHealth = val
		setHealth(val)
var currentHealth = maxHealth

func getHealth():
	return currentHealth

func setHealth(value):
	var oldHealth = currentHealth
	
	currentHealth = min(value, maxHealth)
	print(currentHealth)
	
	if currentHealth < oldHealth and value > 0:
		if owner.state.find_child("Hurt") != null:
			owner.state.change_state("Hurt")
	
	if value <= 0 and owner.state != owner.STATE_DEATH:
		hurtbox.call_deferred("set_disabled", true)
		owner.state.change_state("Death")
