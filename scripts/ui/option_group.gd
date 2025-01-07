extends CanvasLayer

@onready var sound_settings_button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/SoundSettingsButton
@onready var ui_transition_sideways = $UITransitionSideways 
@onready var transition_sideways = $UITransitionSideways/SceneTransistion/AnimationPlayer

@onready var sound_settings_scene = preload("res://scenes/ui/ui_sound_settings.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sound_settings_button.grab_focus()

	ui_transition_sideways.visible = true
	transition_sideways.play("rect_out")
	await transition_sideways.animation_finished
	ui_transition_sideways.visible = false

func _on_sound_settings_button_pressed() -> void:
	ui_transition_sideways.visible = true
	transition_sideways.play("rect_in")
	await transition_sideways.animation_finished
	call_deferred("_change_scene_to_sound_settings")

func _change_scene_to_sound_settings() -> void:
	get_tree().change_scene_to_packed(sound_settings_scene)
