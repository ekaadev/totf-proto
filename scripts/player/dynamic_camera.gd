extends Camera2D

# max distance from the center of the screen
var MAX_DISTANCE = 32

# distance from the center of the screen
var target_distance = 0
# center of the screen
var center_pos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# get the direction from the center of the screen to the mouse position
	var direction = center_pos.direction_to(get_local_mouse_position())
	# calculate the target position
	var target_pos = center_pos + direction * target_distance
	
	# clamp the target position to the max distance from the center (batasan)
	target_pos = target_pos.clamp(
		center_pos - Vector2(MAX_DISTANCE, MAX_DISTANCE),
		center_pos + Vector2(MAX_DISTANCE, MAX_DISTANCE)
	)

	# position the camera
	position = target_pos

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# calculate the target distance based on the distance from the center of the screen to the mouse position
		target_distance = center_pos.distance_to(get_local_mouse_position()) / 2
