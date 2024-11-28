extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("idle_right")
	
func take_damage(damage: int) -> void:
	print("Enemy took " + str(damage) + " damage")
