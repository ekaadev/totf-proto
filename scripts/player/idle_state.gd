extends NodeState

@export var player: Player
@export var animation_sprite: AnimatedSprite2D


func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	if player.player_direction == Vector2.UP:
		animation_sprite.play("idle_up")
	elif player.player_direction == Vector2.DOWN:
		animation_sprite.play("idle_down")
	elif player.player_direction == Vector2.LEFT:
		animation_sprite.play("idle_left")
	elif player.player_direction == Vector2.RIGHT:
		animation_sprite.play("idle_right")
	else:
		animation_sprite.play("idle_down")

func _on_next_transitions() -> void:
	GameInputEvents.movement_input()

	if GameInputEvents.is_movement_input():
		transition.emit("Walk")

func _on_enter() -> void:
	pass

func _on_exit() -> void:
	animation_sprite.stop()
