extends EnemyState

@onready var direction: Vector2
var player_entered: bool = false
	
func _process(delta: float) -> void:
	direction = owner.direction
	
	if owner.playerDetectionCooldown > 0:
		owner.playerDetectionCooldown -= delta
		
		owner.playerDetection.disabled = true
	else:
		owner.playerDetectionCooldown = 0
		owner.playerDetection.disabled = false
	
	update_animation()

func update_animation():
	if abs(direction.y) > abs(direction.x):
		if direction.y > 0:
			owner.sprite.play("run_down")
		else:
			owner.sprite.play("run_up")
	else:
		owner.sprite.play("run_side")

func enter():
	super.enter()
	owner.set_physics_process(true)
	set_process(true)

func exit():
	super.exit()
	owner.set_physics_process(false)
	set_process(false)

func transition():
	if player_entered:
		player_entered = false
		get_parent().change_state("Attack")

func _on_player_detection_body_entered(body: Node2D) -> void:
	player_entered = true
