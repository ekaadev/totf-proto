extends CanvasLayer

@export_file("*.tscn") var main_menu_scene_path = "res://scenes/ui/main_menu.tscn"

@onready var sound_settings_button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/SoundSettingsButton
@onready var ui_transition_sideways = $UITransitionSideways 
@onready var transition_sideways = $UITransitionSideways/SceneTransistion/AnimationPlayer

@onready var sound_settings_scene = preload("res://scenes/ui/ui_sound_settings.tscn")
@onready var display_settings_scene = preload("res://scenes/ui/ui_display_settings.tscn")

var main_menu_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu_scene = load(main_menu_scene_path)
	if !main_menu_scene:
		push_error("Failed to load main menu scene")

	sound_settings_button.grab_focus()

	ui_transition_sideways.visible = true
	transition_sideways.play("rect_out")
	await transition_sideways.animation_finished
	ui_transition_sideways.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		_on_back_button_pressed()


func _on_display_settings_button_pressed() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_selected, -50)

	ui_transition_sideways.visible = true
	transition_sideways.play("rect_in")
	await transition_sideways.animation_finished
	call_deferred("_change_scene_to_display_settings")

func _change_scene_to_display_settings() -> void:
	get_tree().change_scene_to_packed(display_settings_scene)

func _on_sound_settings_button_pressed() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_selected, -50)

	ui_transition_sideways.visible = true
	transition_sideways.play("rect_in")
	await transition_sideways.animation_finished
	call_deferred("_change_scene_to_sound_settings")

func _change_scene_to_sound_settings() -> void:
	get_tree().change_scene_to_packed(sound_settings_scene)

func _on_back_button_pressed() -> void:
	if !main_menu_scene:
		push_error("Scene not loaded")
		return

	AudioAssets.play_sfx(AudioAssets.menu_cancel, -50)

	ui_transition_sideways.visible = true
	transition_sideways.play("rect_in")
	await transition_sideways.animation_finished
	call_deferred("_change_scene_to_main_menu")

func _change_scene_to_main_menu() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)


func _on_sound_settings_button_focus_entered() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -60)


func _on_display_settings_button_focus_entered() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -60)