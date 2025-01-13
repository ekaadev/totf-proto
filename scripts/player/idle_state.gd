extends NodeState

# PLAYER IDLE STATE

@export var player: Player
@export var animation_player: AnimationPlayer


# process function
# if stamina from player is less than 100, call the regen_stamina function
func _on_process(delta : float) -> void:
	if owner.find_child("StaminaPlayerComponent").stamina < 100:
		owner.find_child("StaminaPlayerComponent").regen_stamina(delta)

# physics process function
# check the player direction and play the animation based on the direction
func _on_physics_process(_delta: float) -> void:
	var direction = player.player_direction

	if direction.x != 0 and direction.y != 0:
		if direction.y > 0:
			if direction.x < 0:
				owner.get_node("Sprite2D").flip_h = true
				owner.get_node("Sprite2D").offset = Vector2(-12.5, -7)
				animation_player.play("idle_down")
			else:
				owner.get_node("Sprite2D").flip_h = false
				owner.get_node("Sprite2D").offset = Vector2(12.5, -7)
				animation_player.play("idle_down")
		else:
			if direction.x < 0:
				owner.get_node("Sprite2D").flip_h = true
				owner.get_node("Sprite2D").offset = Vector2(-12.5, -7)
				animation_player.play("idle_up")
			else:
				owner.get_node("Sprite2D").flip_h = false
				owner.get_node("Sprite2D").offset = Vector2(12.5, -7)
				animation_player.play("idle_up")
	else:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				owner.get_node("Sprite2D").flip_h = false
				owner.get_node("Sprite2D").offset = Vector2(12.5, -7)
				animation_player.play("idle_lr")
			else:
				owner.get_node("Sprite2D").flip_h = true
				owner.get_node("Sprite2D").offset = Vector2(-12.5, -7)
				animation_player.play("idle_lr")
		else:
			if direction.y > 0:
				animation_player.play("idle_down")
			else:
				animation_player.play("idle_up")

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

	if player.current_tool == DataTypes.Tools.Spear && GameInputEvents.use_tool() && owner.find_child("StaminaPlayerComponent").stamina >= 3:
		# change to state basic attack
		transition.emit("BasicAttack")

	if player.current_tool == DataTypes.Tools.Spear && GameInputEvents.use_slash() && owner.find_child("StaminaPlayerComponent").stamina >= 5:
		transition.emit("SlashAttack")

	
		
# enter function
# set the can_regen to true
func _on_enter() -> void:
	owner.find_child("StaminaPlayerComponent").can_regen = true

# exit function
# stop the animation
# set the can_regen to false
func _on_exit() -> void:
	animation_player.stop()
	owner.find_child("StaminaPlayerComponent").can_regen = false