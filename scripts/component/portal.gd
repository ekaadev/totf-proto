extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var ui_transition_sideways = owner.get_node("UITransitionSideways")
@onready var transition = ui_transition_sideways.get_node("SceneTransistion/AnimationPlayer")

# PROBLEM SOLVE : ABOUT 

@export_file("*.tscn") var blood_forest_desert_path = "res://scenes/map/blood_forest_desert.tscn"
var blood_forest_desert: PackedScene

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_portal")

	# blood_forest_desert = load(blood_forest_desert_path)
	# if !blood_forest_desert:
	# 	push_error("Failed to load blood forest desert scene")

func _on_portal():
	# if !blood_forest_desert:
	# 	push_error("Scene not loaded")
	# 	return

	LoadManager.load_scene(blood_forest_desert_path, "res://scenes/loading/sideways.tscn")

	# ui_transition_sideways.visible = true
	# transition.play("rect_in")
	# await transition.animation_finished
	# call_deferred("_change_scene_to_blood_forest_desert")

func _change_scene_to_blood_forest_desert():
	if blood_forest_desert:
		get_tree().change_scene_to_packed(blood_forest_desert)
	else:
		push_error("Cannot change to null scene")
