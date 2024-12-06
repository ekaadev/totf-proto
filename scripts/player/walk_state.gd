extends NodeState

# PLAYER WALK STATE

@export var player: Player
@export var animation_sprite: AnimatedSprite2D

@export var max_speed = 180
@export var accel = 1500
@export var friction = 600

# on process function
# if stamina from player is less than 100, call the regen_stamina function
func _on_process(delta : float) -> void:
	if owner.find_child("StaminaPlayerComponent").stamina < 100:
		owner.find_child("StaminaPlayerComponent").regen_stamina(delta)

# on physics process function
# check the player direction and play the animation based on the direction
# if player is moving, set the player direction and velocity
func _on_physics_process(_delta : float) -> void:
	var direction = GameInputEvents.movement_input()

	if direction == Vector2.UP:
		animation_sprite.play("walk_up")
	elif direction == Vector2.DOWN:
		animation_sprite.play("walk_down")
	elif direction == Vector2.LEFT:
		animation_sprite.play("walk_left")
	elif direction == Vector2.RIGHT:
		animation_sprite.play("walk_right")

	if direction != Vector2.ZERO:
		player.player_direction = direction

	# can improve with smooth movement
	player.velocity = direction * max_speed
	player.move_and_slide()

# on next transitions function
# check the player movement input, if player is not moving, emit the idle transition
# if player is using tool and the stamina is more than 10, emit the basic attack transition
# if player is using dash and the stamina is more than 20, emit the dash transition
func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		# change to state idle
		transition.emit("Idle")

	if player.current_tool == DataTypes.Tools.Spear && GameInputEvents.use_tool() && owner.find_child("StaminaPlayerComponent").stamina >= 10:
		# change to state basic attack
		transition.emit("BasicAttack")

	if GameInputEvents.use_daash() && owner.find_child("StaminaPlayerComponent").stamina >= 30:
		# change to state dash
		transition.emit("Dash")

# on enter function
# set the can_regen to true
func _on_enter() -> void:
	owner.find_child("StaminaPlayerComponent").can_regen = true

# on exit function
# stop the animation
# set the can_regen to false
func _on_exit() -> void:
	animation_sprite.stop()
	owner.find_child("StaminaPlayerComponent").can_regen = false
