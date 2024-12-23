extends NodeState

# PLAYER BASIC ATTACK STATE

@export var player: Player
@export var animation_player: AnimationPlayer

@onready var hitbox_component = owner.get_node("HitboxComponent")
@onready var collision_shape = hitbox_component.get_node("CollisionShape2D")

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
	if !animation_player.is_playing():
		# change to state idle
		transition.emit("Idle")
	
	if GameInputEvents.use_dash() && owner.find_child("StaminaPlayerComponent").stamina >= 20:
		# change to state dash
		transition.emit("Dash")

# on enter function
# check the player direction and play the animation based on the direction
# take stamina from player
func _on_enter() -> void:
	var direction = player.player_direction

	if direction.x != 0 and direction.y != 0:
		if direction.y > 0:
			if direction.x < 0:
				owner.get_node("Sprite2D").flip_h = true
				owner.get_node("Sprite2D").offset = Vector2(-12.5, -7)
				animation_player.play("chop_down")
			else:
				owner.get_node("Sprite2D").flip_h = false
				owner.get_node("Sprite2D").offset = Vector2(12.5, -7)
				animation_player.play("chop_down")
		else:
			if direction.x < 0:
				owner.get_node("Sprite2D").flip_h = true
				owner.get_node("Sprite2D").offset = Vector2(-12.5, -7)
				animation_player.play("chop_up")
			else:
				owner.get_node("Sprite2D").flip_h = false
				owner.get_node("Sprite2D").offset = Vector2(12.5, -7)
				animation_player.play("chop_up")
	else:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				owner.get_node("Sprite2D").flip_h = false
				owner.get_node("Sprite2D").offset = Vector2(12.5, -7)
				animation_player.play("chop_lr")
			else:
				owner.get_node("Sprite2D").flip_h = true
				owner.get_node("Sprite2D").offset = Vector2(-12.5, -7)
				animation_player.play("chop_lr")
		else:
			if direction.y > 0:
				animation_player.play("chop_down")
			else:
				animation_player.play("chop_up")
	

	owner.take_stamina(3)

# on exit function
# stop the animation
func _on_exit() -> void:
	pass