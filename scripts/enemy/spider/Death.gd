extends EnemyState

func enter():
	super.enter()
	owner.queue_free()
