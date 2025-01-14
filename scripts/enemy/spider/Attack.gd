extends EnemyState

var anim_finished: bool = false

func enter():
	super.enter()
	
	owner.sprite.play("attack_side")
	
	await owner.sprite.animation_finished
	
	anim_finished = true
	owner.playerDetectionCooldown = 1.0

func transition():
	if anim_finished:
		owner.scatterPhases = 16
		owner.distance = Vector2.ZERO
		anim_finished = false
		get_parent().change_state("Follow")
