extends CanvasLayer

@onready var prolog_animation = $PrologAnimation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prolog_animation.play("in")
	await prolog_animation.animation_finished
	save_prolog()
	LoadManager.load_scene("res://scenes/map/green_garden.tscn", "res://scenes/loading/sideways.tscn")

func save_prolog() -> void:
	var config = ConfigFile.new()
	config.set_value("prolog", "seen", true)
	config.save("user://player_config_prolog.cfg")