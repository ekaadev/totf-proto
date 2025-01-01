extends Control

@onready var ui_transition_sideways = $UITransitionSideways 
@onready var transition = $UITransitionSideways/SceneTransistion/AnimationPlayer

var green_garden = preload("res://scenes/map/green_garden.tscn")

func _on_start_button_pressed() -> void:
	ui_transition_sideways.visible = true
	transition.play("rect_in")
	await transition.animation_finished
	call_deferred("_change_scene_to_green_garden")

func _change_scene_to_green_garden() -> void:
	get_tree().change_scene_to_packed(green_garden)
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()

