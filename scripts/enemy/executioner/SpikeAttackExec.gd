extends EnemyState

var can_transition: bool = false
@onready var direction: Vector2

func enter():
	super.enter()
	direction = player.position - owner.position

	# Compare X and Y differences to determine attack direction
	var x_diff = abs(direction.x)
	var y_diff = abs(direction.y)

	if x_diff > y_diff:
		# Horizontal attack
		if direction.x < 0:
			animation_player.play("attack1")
		else:
			animation_player.play("attack2")
	else:
		# Vertical attack
		if direction.y < 0:
			animation_player.play("attack2")
		else:
			animation_player.play("attack1")
			
	await animation_player.animation_finished
	can_transition = true

func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Follow")
