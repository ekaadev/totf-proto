extends NodeState

@export var player: Player
@export var animation_sprite: AnimatedSprite2D

@export var max_speed = 180
@export var accel = 1500
@export var friction = 600


func _on_process(_delta : float) -> void:
	pass

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

func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")

	if player.current_tool == DataTypes.Tools.Spear && GameInputEvents.use_tool():
		transition.emit("BasicAttack")

	if GameInputEvents.use_daash():
		transition.emit("Dash")

func _on_enter() -> void:
	pass

func _on_exit() -> void:
	animation_sprite.stop()
