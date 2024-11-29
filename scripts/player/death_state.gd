extends NodeState

@export var player: Player
@export var animation_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	pass

func _on_next_transitions() -> void:
	pass

# on enter function
# check the player direction and play the animation based on the direction
# play the player slained animation
# wait for the animation to finish
func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		animation_sprite.play("death_up")
	elif player.player_direction == Vector2.DOWN:
		animation_sprite.play("death_down")
	elif player.player_direction == Vector2.LEFT:
		animation_sprite.play("death_left")
	elif player.player_direction == Vector2.RIGHT:
		animation_sprite.play("death_right")
	
	await animation_sprite.animation_finished
	animation_player.play("player_slained")
	await animation_player.animation_finished

func _on_exit() -> void:
	pass
