extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var ui_transition_sideways = owner.get_node("UITransitionSideways")
@onready var transition = ui_transition_sideways.get_node("SceneTransistion/AnimationPlayer")

var blood_forest_desert = preload("res://scenes/map/blood_forest_desert.tscn")

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_portal")

func _on_portal():
	ui_transition_sideways.visible = true
	transition.play("rect_in")
	await transition.animation_finished
	call_deferred("_change_scene_to_blood_forest_desert")

func _change_scene_to_blood_forest_desert():
	get_tree().change_scene_to_packed(blood_forest_desert)
