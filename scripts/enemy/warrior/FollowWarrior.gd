extends EnemyState

@onready var direction: Vector2
	
func _process(_delta: float) -> void:
	direction = owner.direction
	update_animation()

func update_animation():
	# Compare X and Y differences to determine primary direction
	var x_diff = abs(direction.x)
	var y_diff = abs(direction.y)
	
	if x_diff > y_diff:
		# Horizontal movement is primary
		if direction.x < 0:
			animation_player.play("move_lr")
		else:
			animation_player.play("move_lr")
	else:
		# Vertical movement is primary
		if player.position.y < owner.position.y:
			# Player is above beast
			animation_player.play("move_up")
		else:
			# Player is below beast
			animation_player.play("move_down")

func enter():
	super.enter()
	owner.set_physics_process(true)
	set_process(true)
	update_animation()

func exit():
	super.exit()
	owner.set_physics_process(false)
	set_process(false)

func transition():
	var distance = owner.direction.length()

	if distance < 80:
		get_parent().change_state("SpikeAttack")
