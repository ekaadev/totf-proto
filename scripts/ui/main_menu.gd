extends Control

@onready var ui_transition_sideways = $UITransitionSideways 
@onready var transition = $UITransitionSideways/SceneTransistion/AnimationPlayer
@onready var ui_transition_fade = $UITransitionFade
@onready var transition_fade = $UITransitionFade/GameOverAnimation
@onready var start_button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/StartButton

var can_pressed = true

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

	if can_pressed:
		AudioAssets.play_sfx(AudioAssets.menu_selected, -50)
		LoadManager.load_scene("res://scenes/map/green_garden.tscn", "res://scenes/loading/sideways.tscn")
		AudioAssets.stop_music()
		can_pressed = false
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()

# improve with new ui in section option
func _on_option_button_pressed() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_selected, -50)

	LoadManager.load_scene("res://scenes/ui/option_group.tscn", "res://scenes/loading/sideways.tscn")

func _on_start_button_focus_entered() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -60)

func _on_option_button_focus_entered() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -60)

func _on_exit_button_focus_entered() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -60)
