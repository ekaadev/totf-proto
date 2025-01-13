extends Node

# ui stamina bar component
@onready var stamina_bar = $"../HUDAvatarPlayer/MarginContainer/HBoxContainer/VBoxContainer/TextureRect/ManaPower"

# stamina properties
var can_regen = true
var max_stamina = 100
var regen_rate = 10

# stamina value
# default value is 100
# set the value to the stamina bar
# clamp the value between 0 and max_stamina
@export var stamina = 100:
	set(value):
		stamina = clamp(value, 0, max_stamina)
		stamina_bar.value = value

# regen stamina function
# if can_regen is true and stamina is less than max_stamina
# add the regen_rate to stamina
func regen_stamina(delta: float) -> void:
	if can_regen and stamina < max_stamina:
		stamina += regen_rate * delta
