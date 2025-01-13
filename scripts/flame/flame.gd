extends StaticBody2D

# interaction area
@onready var interaction_area = $InteractionArea
# animated sprite (flame animation)
@onready var flame_animation_player = $AnimationPlayer

var toggle = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connect the interact signal of the interaction area to the _toggle_flame method
	interaction_area.interact = Callable(self, "_toggle_flame")

func _toggle_flame():
	if !toggle:
		# play the flame animation if it's off
		flame_animation_player.play("idle_on")
		# set the toggle flag to true
		toggle = true
	else:
		# stop the flame animation if it's on
		flame_animation_player.play("idle_off")
		# set the toggle flag to false
		toggle = false
