extends CharacterBody2D

@onready var player = get_parent().find_child("Player")
@onready var sprite = $AnimatedSprite2D
@onready var healthComponent = $HealthComponentNew

var direction: Vector2
var distance: Vector2

var scatterPhases = 32

var dirArray = [Vector2(-1, 0), Vector2(1, 0), Vector2(0, -1), Vector2(0, 1)]

func _ready() -> void:
	randomize()
	
	direction = Vector2(-1, 0)

func _process(delta: float) -> void:
	if scatterPhases > 0:
		if direction.y == 0 and abs(distance.x) >= 8:
			scatterPhases -= 1 if scatterPhases > 0 else 0
			
			if scatterPhases > 0:
				var tempDir = -direction
				
				while tempDir == -direction:
					tempDir = dirArray.pick_random()
				
				direction = tempDir
				distance = Vector2.ZERO
		elif direction.x == 0 and abs(distance.y) >= 8:
			scatterPhases -= 1 if scatterPhases > 0 else 0
			
			var tempDir = -direction
			
			while tempDir == -direction:
				tempDir = dirArray.pick_random()
			
			direction = tempDir
			distance = Vector2.ZERO
	else:
		if (direction.y == 0 and abs(distance.x) >= 64) or (direction.x == 0 and abs(distance.y) >= 64):
			var randomNoise = randf()
			
			if randomNoise > 0.8:
				scatterPhases += randi_range(1, 5) * 4
				
				var tempDir = -direction
				
				while tempDir == -direction:
					tempDir = dirArray.pick_random()
				
				direction = tempDir
				distance = Vector2.ZERO
			else:
				var tempDir = player.position - position
				
				if abs(tempDir.x) >= abs(tempDir.y):
					# move on the X axis
					if tempDir.x > 0:
						tempDir = dirArray[1]
					elif tempDir.x < 0:
						tempDir = dirArray[0]
				else:
					# move on the Y axis
					
					if tempDir.y > 0:
						tempDir = dirArray[3]
					elif tempDir.y < 0:
						tempDir = dirArray[2]
				
				direction = tempDir
				distance = Vector2.ZERO
	
	if abs(direction.y) > abs(direction.x):
		if direction.y > 0:
			sprite.play("run_down")
		else:
			sprite.play("run_up")
	else:
		sprite.play("run_side")
	
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * 180
	move_and_collide(velocity * delta)
	
	distance += velocity * delta

func take_damage(damage: int) -> void:
	healthComponent.setHealth(healthComponent.getHealth() - damage)
