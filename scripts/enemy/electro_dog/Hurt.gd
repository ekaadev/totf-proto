extends EnemyState

func enter():
	super.enter()
	
	owner.sprite.play("hit_side")
	await owner.sprite.animation_finished
	
	get_parent().change_state("Follow")
