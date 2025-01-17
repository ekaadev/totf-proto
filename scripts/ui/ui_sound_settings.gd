extends CanvasLayer

@onready var ui_transition_sideways = $UITransitionSideways 
@onready var transition_sideways = $UITransitionSideways/SceneTransistion/AnimationPlayer
@onready var master_slider = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/MasterSlider
@onready var music_slider = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/MusicSlider
@onready var sfx_slider = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/SFXSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master_slider.value = AudioManager.master_volume
	music_slider.value = AudioManager.music_volume
	sfx_slider.value = AudioManager.sfx_volume

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
	AudioAssets.play_sfx(AudioAssets.menu_cancel, -50)

	LoadManager.load_scene("res://scenes/ui/option_group.tscn", "res://scenes/loading/sideways.tscn")