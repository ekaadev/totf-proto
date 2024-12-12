extends EnemyState

@onready var direction: Vector2
	
func _process(_delta: float) -> void:
	direction = owner.direction

func enter():
	super.enter()
	owner.set_physics_process(true)
	set_process(true)

func exit():
	super.exit()
	owner.set_physics_process(false)
	set_process(false)
