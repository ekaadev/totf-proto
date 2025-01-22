extends StaticBody2D

# interaction area
@onready var interaction_area = $InteractionArea
# animated sprite (flame animation)
@onready var flame_animation_player = $AnimationPlayer
@onready var notification_animation = owner.get_node("UINotificationUnSuccess/NotificationAnimation")

var toggle = false
var energy_needed = 10000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_energy_player = load_energy()
	# connect the interact signal of the interaction area to the _toggle_flame method
	interaction_area.interact = Callable(self, "_toggle_flame")
	var energy_diff = energy_needed - current_energy_player
	interaction_area.action_name = "ACTIVATE" if energy_diff <= 0 else "ACTIVATE, NEED %s ENERGY" % energy_diff

func _toggle_flame():
	if !toggle and load_energy() >= energy_needed and !load_ending():
		# play the flame animation if it's off
		flame_animation_player.play("idle_on")
		# Disable interaction
		interaction_area.set_deferred("monitoring", false)
		interaction_area.set_deferred("monitorable", false)
		# load the ending scene
		LoadManager.load_scene("res://scenes/ui/ui_ending.tscn", "res://scenes/loading/fade.tscn")
	elif !toggle and load_ending() == true:
		notification_animation.play("in_2")
	else:
		notification_animation.play("in")

func load_energy() -> int:
	# load energy from the flame
	var config = ConfigFile.new()
	var energy = 0
	var err = config.load("user://player_energy.cfg")
	if err == OK:
		energy = config.get_value("energy", "counter_energy", 0)  # Default 0 if not found
	
	return energy

func load_ending() -> bool:
	# load ending from the flame
	var config = ConfigFile.new()
	var ending = false
	var err = config.load("user://player_config_ending.cfg")
	if err == OK:
		ending = config.get_value("ending", "seen", false)  # Default false if not found
	
	return ending