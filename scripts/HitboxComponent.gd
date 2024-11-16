extends Area2D
class_name HitboxComponent

@export var damage: int = 10

func _init() -> void:
	collision_layer = 1
	collision_mask = 0