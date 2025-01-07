extends Control

@onready var ui_transition_sideways = $UITransitionSideways 
@onready var transition = $UITransitionSideways/SceneTransistion/AnimationPlayer

@onready var ui_transition_fade = $UITransitionFade
@onready var transition_fade = $UITransitionFade/GameOverAnimation

@onready var start_button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/StartButton

var green_garden = preload("res://scenes/map/green_garden.tscn")
var option_group = preload("res://scenes/ui/option_group.tscn")

func _ready() -> void:
	AudioAssets.play_music(AudioAssets.menu_music, -60.0)
	start_button.grab_focus()
	
	ui_transition_fade.visible = true
	transition_fade.play("fade_out")
	await transition_fade.animation_finished
	ui_transition_fade.visible = false

func _process(_delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	ui_transition_sideways.visible = true
	transition.play("rect_in")
	AudioAssets.stop_music()
	await transition.animation_finished
	call_deferred("_change_scene_to_green_garden")

func _change_scene_to_green_garden() -> void:
	get_tree().change_scene_to_packed(green_garden)
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_option_button_pressed() -> void:
	ui_transition_sideways.visible = true
	transition.play("rect_in")
	await transition.animation_finished
	call_deferred("_change_scene_to_option_group")

func _change_scene_to_option_group() -> void:
	get_tree().change_scene_to_packed(option_group)

func _on_start_button_focus_entered() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -40)
