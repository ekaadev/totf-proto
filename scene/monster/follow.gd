extends State
 
func _enter_tree():
	randomize()
 
func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("idle_right")
 
func exit():
	super.exit()
	owner.set_physics_process(false)
 
func transition():
	if owner.direction.length() < 40:
		get_parent().change_state("hit_right")
