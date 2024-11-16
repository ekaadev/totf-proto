extends NodeState

@export var player: CharacterBody2D
@export var animation_sprite: AnimatedSprite2D

var direction: Vector2
var last_direction = "down"

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	direction = GameInputEvents.movement_input()

	if direction == Vector2.ZERO:
		animation_sprite.play("idle_" + last_direction)
	else:
		if direction.x != 0 and direction.y != 0:
			if direction.x > 0:
				last_direction = "up_right" if direction.y < 0 else "down_right"
			else:
				last_direction = "up_left" if direction.y < 0 else "down_left"
		else:
			# horizontal atau vertical
			if abs(direction.x) > abs(direction.y):
				if direction.x > 0:
					last_direction = "down_right"
				else:
					last_direction = "down_left"
			else:
				if direction.y > 0:
					last_direction = "down"
				else:
					last_direction = "up"
		animation_sprite.play("idle_" + last_direction)

func _on_next_transitions() -> void:
	if direction != Vector2.ZERO:
		transition.emit("Walk")

func _on_enter() -> void:
	pass

func _on_exit() -> void:
	animation_sprite.stop()
