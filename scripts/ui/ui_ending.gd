extends CanvasLayer

@onready var ending_animation = $EndingAnimation


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ending_animation.play("in")
	await ending_animation.animation_finished
	save_endings()
	LoadManager.load_scene("res://scenes/ui/user_interface_main_menu.tscn", "res://scenes/loading/fade.tscn")

func save_endings() -> void:
	var config = ConfigFile.new()
	config.set_value("ending", "seen", true)
	config.save("user://player_config_ending.cfg")