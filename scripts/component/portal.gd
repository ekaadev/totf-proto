extends StaticBody2D

@onready var interaction_area = $InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_portal")

# on portal function
# load scene blood forest desert when interacted
# load scene have 2 parameters
# 1. scene path
# 2. loading scene path
func _on_portal():
	LoadManager.load_scene("res://scenes/map/blood_forest_desert.tscn", "res://scenes/loading/sideways.tscn")
	AudioAssets.stop_music()
