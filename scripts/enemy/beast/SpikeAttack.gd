extends EnemyState

var can_transition: bool = false
@onready var direction: Vector2

# on enter function
# play the attack animation based on the player direction
# wait for the animation to finish
# set can transition to true, if the animation is finished
func enter():
	super.enter()
	direction = player.position - owner.position

	# Compare X and Y differences to determine attack direction
	var x_diff = abs(direction.x)
	var y_diff = abs(direction.y)

	if x_diff > y_diff:
		# Horizontal attack
		if direction.x < 0:
			animation_player.play("attack_lr")
		else:
			animation_player.play("attack_lr")
	else:
		# Vertical attack
		if direction.y < 0:
			animation_player.play("attack_up")
		else:
			animation_player.play("attack_down")
			
	await animation_player.animation_finished
	can_transition = true

# on transition function
# if can transition is true
# set can transition to false
# change the state to Follow
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Follow")
