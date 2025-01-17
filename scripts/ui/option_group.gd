extends CanvasLayer

@onready var sound_settings_button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/SoundSettingsButton
@onready var info_label = $MarginContainer/VBoxContainer/MarginContainer2/InfoLabel

var main_menu_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	sound_settings_button.grab_focus()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		_on_back_button_pressed()

func _on_display_settings_button_pressed() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_selected, -50)

	LoadManager.load_scene("res://scenes/ui/ui_display_settings.tscn", "res://scenes/loading/sideways.tscn")

func _on_sound_settings_button_pressed() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_selected, -50)

	LoadManager.load_scene("res://scenes/ui/ui_sound_settings.tscn", "res://scenes/loading/sideways.tscn")

func _on_back_button_pressed() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cancel, -50)

	LoadManager.load_scene("res://scenes/ui/main_menu.tscn", "res://scenes/loading/sideways.tscn")

func _on_sound_settings_button_focus_entered() -> void:
	info_label.text = "INFO: Sound settings for the game"
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -60)

func _on_display_settings_button_focus_entered() -> void:
	info_label.text = "INFO: Display settings for the game"
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -60)