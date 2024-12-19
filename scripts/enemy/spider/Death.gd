extends EnemyState

func enter():
	super.enter()
	
	owner.sprite.play("death")
	await owner.sprite.animation_finished
	
	owner.queue_free()
