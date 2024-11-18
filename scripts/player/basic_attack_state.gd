extends NodeState

@export var player: Player
@export var animation_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	if !animation_sprite.is_playing():
		transition.emit("Idle")

func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		animation_sprite.play("attack_spear_up")
	elif player.player_direction == Vector2.DOWN:
		animation_sprite.play("attack_spear_down")
		animation_player.play("attack_down")
	elif player.player_direction == Vector2.LEFT:
		animation_sprite.play("attack_spear_left")
	elif player.player_direction == Vector2.RIGHT:
		animation_sprite.play("attack_spear_right")
	else:
		animation_sprite.play("attack_spear_down")

func _on_exit() -> void:
	animation_sprite.stop()
