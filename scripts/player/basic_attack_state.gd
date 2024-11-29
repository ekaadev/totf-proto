extends NodeState

# PLAYER BASIC ATTACK STATE

@export var player: Player
@export var animation_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

# on process function
func _on_process(_delta : float) -> void:
	pass

# on physics process function
func _on_physics_process(_delta : float) -> void:
	pass

# on next transitions function
# if animation is not playing, emit the idle transition
# if player is using tool and the stamina is more than 20, emit the dash transition
func _on_next_transitions() -> void:
	if !animation_sprite.is_playing():
		# change to state idle
		transition.emit("Idle")
	
	if GameInputEvents.use_daash() && owner.find_child("StaminaPlayerComponent").stamina >= 20:
		# change to state dash
		transition.emit("Dash")

# on enter function
# check the player direction and play the animation based on the direction
# take stamina from player
func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		animation_sprite.play("attack_spear_up")
		animation_player.play("attack_up")
	elif player.player_direction == Vector2.DOWN:
		animation_sprite.play("attack_spear_down")
		animation_player.play("attack_down")
	elif player.player_direction == Vector2.LEFT:
		animation_sprite.play("attack_spear_left")
		animation_player.play("attack_left")
	elif player.player_direction == Vector2.RIGHT:
		animation_sprite.play("attack_spear_right")
		animation_player.play("attack_right")
	else:
		animation_sprite.play("attack_spear_down")
		animation_player.play("attack_down")
	
	owner.take_stamina(10)

# on exit function
# stop the animation
func _on_exit() -> void:
	animation_sprite.stop()
