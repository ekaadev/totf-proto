extends NodeState

@export var player: Player
@export var animation_player: AnimationPlayer
@export var dash_distance: float = 100.0

var can_dash = true
var dash_direction: Vector2 = Vector2.ZERO
var is_dashing = false


func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	pass
# on next transitions function
# if player is not dashing, emit the idle transition
func _on_next_transitions() -> void:
	if !can_dash:
		transition.emit("Idle")

func _on_enter() -> void:
	owner.gpu_particles.emitting = true

	# Create a raycast to check for collisions
	var space_state = player.get_world_2d().direct_space_state
	
	## Set up raycast parameters
	## @return PhysicsRayQueryParameters2D
	# Creates a 2D physics ray query to check for collisions along the dash path
	# Parameters for the query are set from the player's current position to
	# the target position (calculated by player direction * dash distance)
	#
	# @param PhysicsRayQueryParameters2D.create - Creates new physics ray query
	# @param player.position - Starting point of the ray (current player position)
	# @param player.player_direction - Normalized vector of player's facing direction
	# @param dash_distance - Maximum distance of the dash
	var query = PhysicsRayQueryParameters2D.create(
		player.position,
		player.position + player.player_direction * dash_distance
	)
	## Excludes the player object from the query results to prevent self-collision during dash
	## The query is used for collision detection during the dash movement
	##
	## @param query The collision query instance
	## @param player The player node reference that should be excluded
	query.exclude = [player]
	# Collision layer for environment
	query.collision_mask = 4

	# Perform the raycast
	var result = space_state.intersect_ray(query)
	
	# Handles collision during dash movement
	# If a collision is detected during dash:
	# 1. Calculates the distance between player and collision point
	# 2. Adjusts dash distance to prevent clipping through walls
	# 3. Adds a 10-unit buffer to ensure player stops before the collision point
	if result:
		# If there's a collision, adjust dash distance
		# collision_distance = distance between player and collision point (enviroment position)
		var collision_distance = player.position.distance_to(result.position)
		# Leave some buffer
		# dash distance berada di antara 0 dan collision_distance - 10
		dash_distance = min(dash_distance, collision_distance - 10.0)  
	
	# Perform dash based on direction
	var tween = create_tween()

	var direction = player.player_direction

	if direction.x != 0 and direction.y != 0:
		if direction.y > 0:
			if direction.x < 0:
				owner.get_node("Sprite2D").flip_h = true
				owner.get_node("Sprite2D").offset = Vector2(-12.5, -7)
				tween.tween_property(player, "position", 
					player.position + (direction.normalized() * dash_distance), 
					0.25).set_ease(Tween.EASE_OUT)
			else:
				owner.get_node("Sprite2D").flip_h = false
				owner.get_node("Sprite2D").offset = Vector2(12.5, -7)
				tween.tween_property(player, "position", 
					player.position + (direction.normalized() * dash_distance), 
					0.25).set_ease(Tween.EASE_OUT)
		else:
			if direction.x < 0:
				owner.get_node("Sprite2D").flip_h = true
				owner.get_node("Sprite2D").offset = Vector2(-12.5, -7)
				tween.tween_property(player, "position", 
					player.position + (direction.normalized() * dash_distance), 
					0.25).set_ease(Tween.EASE_OUT)
			else:
				owner.get_node("Sprite2D").flip_h = false
				owner.get_node("Sprite2D").offset = Vector2(12.5, -7)
				tween.tween_property(player, "position", 
					player.position + (direction.normalized() * dash_distance), 
					0.25).set_ease(Tween.EASE_OUT)
	else:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				tween.tween_property(player, "position", 
					player.position + (Vector2.RIGHT * dash_distance), 
					0.25).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(player, "position", 
					player.position + (Vector2.LEFT * dash_distance), 
					0.25).set_ease(Tween.EASE_OUT)
		else:
			if direction.y > 0:
				tween.tween_property(player, "position", 
					player.position + (Vector2.DOWN * dash_distance), 
					0.25).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(player, "position", 
					player.position + (Vector2.UP * dash_distance), 
					0.25).set_ease(Tween.EASE_OUT)
					
	# Play the dash animation	
	# take stamina from player
	owner.take_stamina(30)
	await tween.finished

	owner.gpu_particles.emitting = false

	can_dash = false
	# Reset dash distance
	dash_distance = 100.0  

func _on_exit() -> void:
	pass