extends CharacterBody2D

# movement variable
const max_speed = 180
const accel = 1500
const friction = 600
var running = false
var last_direction = "down"

var state = "walk_"

@onready var animated_sprite = $AnimatedSprite2D
@onready var footstep_sfx = $FootstepsPlayerSFX

# Input for movement
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	return input_direction
	
# Control & Adjust Movement
func player_movement(input, delta):
	# jika bergerak
	if input:
		# jika running, set velocity lebih cepat dari velocity normal
		running = Input.is_action_pressed("run")
		if running: 
			velocity = velocity.move_toward(input * max_speed * 1.4, delta * accel)
		else : 
			# jika tidak running, set velocity normal
			velocity = velocity.move_toward(input * max_speed, delta * accel)
	else:
		# jika tidak bergerak, set velocity menjadi nol
		velocity = velocity.move_toward(Vector2(0,0), delta * friction)

# Movement & Animation
func _physics_process(delta):
	var input = get_input()
	player_movement(input, delta)
	update_sfx()
	move_and_slide()
	update_animation()
	

# Animation
func update_animation():
	if velocity == Vector2.ZERO:
		# jika tidak bergerak, set animasi idle sesuai dengan arah terakhir
		animated_sprite.play("idle_" + last_direction)
	else:
		state = "run_" if running else "walk_"
		# diagonal
		if velocity.x != 0 and velocity.y != 0:
			if velocity.x > 0:
				last_direction = "up_right" if velocity.y < 0 else "down_right"
			else:
				last_direction = "up_left" if velocity.y < 0 else "down_left"
		else:
			# horizontal atau vertical
			if abs(velocity.x) > abs(velocity.y):
				if velocity.x > 0:
					last_direction = "down_right"
				else:
					last_direction = "down_left"
			else:
				last_direction = "down" if velocity.y > 0 else "up"
		# perbarui bagian ini jika ingin menggunakan animation run
		animated_sprite.play(state + last_direction)
		# debug state animation
		print(state + last_direction)
		
func update_sfx():
#	check, apakah player bergerak
	if velocity != Vector2.ZERO:
#		jika bergerak, check apakah time_left nya kurang dari 0
		if $Timer.time_left <= 0:
			footstep_sfx.pitch_scale = randf_range(0.8, 1.2)
			footstep_sfx.play()
			$Timer.start(0.4)
