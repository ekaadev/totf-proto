extends NodeState

@export var player: CharacterBody2D
@export var animation_sprite: AnimatedSprite2D

@export var max_speed = 180
@export var accel = 1500
@export var friction = 600

var direction: Vector2
var last_direction = "down"

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	direction = GameInputEvents.movement_input()

	if direction.x != 0 and direction.y != 0:
		if direction.x > 0:
			last_direction = "up_right" if direction.y < 0 else "down_right"
		else:
			last_direction = "up_left" if direction.y < 0 else "down_left"
	else:
		# horizontal or vertical
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
	animation_sprite.play("walk_" + last_direction)

	# can improve with smooth movement
	player.velocity = direction * max_speed

	player.move_and_slide()

func _on_next_transitions() -> void:
	if direction == Vector2.ZERO:
		transition.emit("Idle")

func _on_enter() -> void:
	pass

func _on_exit() -> void:
	animation_sprite.stop()
