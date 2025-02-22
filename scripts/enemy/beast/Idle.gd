extends EnemyState

# BEAST IDLE STATE

@onready var collision = $"../../PlayerDetecion/CollisionShape2D"

# @onready var health_bar = owner.find_child("HealthBar")

# player entered
# set the value, from signal on player detection body entered
# set the collision to disabled
# set the progress bar to visible
var player_entered: bool = false:
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)

		# health_bar.set_deferred("visible", value)

# on transition function
# if the player entered the beast detection area
# change the state to Follow
func transition():
	if player_entered:
		get_parent().change_state("Follow")

# on player detection body entered function
# set the player entered to true
func _on_player_detecion_body_entered(_body:Node2D) -> void:
	player_entered = true
