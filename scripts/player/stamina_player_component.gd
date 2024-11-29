extends Node

@onready var stamina_bar = $"../UIPlayer/StaminaBar"

var can_regen = true
var max_stamina = 100
var regen_rate = 10

@export var stamina = 100:
	set(value):
		stamina = clamp(value, 0, max_stamina)
		stamina_bar.value = value

func regen_stamina(delta: float) -> void:
	if can_regen and stamina < max_stamina:
		stamina += regen_rate * delta
