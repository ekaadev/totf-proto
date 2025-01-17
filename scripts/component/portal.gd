extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var ui_transition_sideways = owner.get_node("UITransitionSideways")
@onready var transition = ui_transition_sideways.get_node("SceneTransistion/AnimationPlayer")

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_portal")

func _on_portal():
	LoadManager.load_scene("res://scenes/map/blood_forest_desert.tscn", "res://scenes/loading/sideways.tscn")
