extends NodeState

# PLAYER IDLE STATE

@export var player: Player
@export var animation_sprite: AnimatedSprite2D

# process function
# if stamina from player is less than 100, call the regen_stamina function
func _on_process(delta : float) -> void:
	if owner.find_child("StaminaPlayerComponent").stamina < 100:
		owner.find_child("StaminaPlayerComponent").regen_stamina(delta)

# physics process function
# check the player direction and play the animation based on the direction
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

# next transitions function
# check the player movement input
# if player is moving, emit the walk transition
# if player is using tool and the stamina is more than 10, emit the basic attack transition
# if player is using dash and the stamina is more than 20, emit the dash transition
func _on_next_transitions() -> void:
	GameInputEvents.movement_input()

	if GameInputEvents.is_movement_input():
		# change to state walk
		transition.emit("Walk")

	if player.current_tool == DataTypes.Tools.Spear && GameInputEvents.use_tool() && owner.find_child("StaminaPlayerComponent").stamina >= 10:
		# change to state basic attack
		transition.emit("BasicAttack")
	
	if GameInputEvents.use_daash() && owner.find_child("StaminaPlayerComponent").stamina >= 20:
		# change to state dash
		transition.emit("Dash")
		
# enter function
# set the can_regen to true
func _on_enter() -> void:
	owner.find_child("StaminaPlayerComponent").can_regen = true

# exit function
# stop the animation
# set the can_regen to false
func _on_exit() -> void:
	animation_sprite.stop()
	owner.find_child("StaminaPlayerComponent").can_regen = false