extends CanvasLayer

@export_file("*.tscn") var option_group_scene_path = "res://scenes/ui/option_group.tscn"

@onready var ui_transition_sideways = $UITransitionSideways 
@onready var transition_sideways = $UITransitionSideways/SceneTransistion/AnimationPlayer

@onready var master_slider = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/MasterSlider
@onready var music_slider = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/MusicSlider
@onready var sfx_slider = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/SFXSlider

var option_group_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	option_group_scene = load(option_group_scene_path)
	if !option_group_scene:
		push_error("Failed to load option group scene")

	master_slider.value = AudioManager.master_volume
	music_slider.value = AudioManager.music_volume
	sfx_slider.value = AudioManager.sfx_volume

	ui_transition_sideways.visible = true
	transition_sideways.play("rect_out")
	await transition_sideways.animation_finished
	ui_transition_sideways.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		_on_back_button_pressed()

func _on_master_slider_value_changed(value: float) -> void:
	AudioManager.master_volume = value

func _on_music_slider_value_changed(value: float) -> void:
	AudioManager.music_volume = value

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioManager.sfx_volume = value

func _on_back_button_pressed() -> void:
	if !option_group_scene:
		push_error("Scene not loaded")
		return

	AudioAssets.play_sfx(AudioAssets.menu_cancel, -50)

	ui_transition_sideways.visible = true
	transition_sideways.play("rect_in")
	await transition_sideways.animation_finished
	call_deferred("_change_scene_to_option_group")

func _change_scene_to_option_group() -> void:
	get_tree().change_scene_to_packed(option_group_scene)