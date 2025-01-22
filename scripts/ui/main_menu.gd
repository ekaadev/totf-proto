extends Control

@onready var ui_transition_fade = $UITransitionFade
@onready var transition_fade = $UITransitionFade/GameOverAnimation
@onready var start_button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/StartButton
@onready var option_button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/OptionButton
@onready var exit_button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/ExitButton
@onready var ui_option = $UIOption
@onready var animation_option = $UIOption/OptionAnimation
@onready var sound_button = $UIOption/MarginContainer/HBoxContainer/VBoxContainer/SoundButton

var can_pressed = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_option.connect("option_closed", Callable(self, "_on_option_closed"))

	AudioAssets.play_music(AudioAssets.menu_music, -65.0)
	start_button.grab_focus()
	
	ui_transition_fade.visible = true
	transition_fade.play("fade_out")
	await transition_fade.animation_finished
	ui_transition_fade.visible = false

func _process(_delta: float) -> void:
	pass

# on start button pressed, load the green garden scene
func _on_start_button_pressed() -> void:

	if can_pressed:
		AudioAssets.play_sfx(AudioAssets.menu_selected, -50)

		# Check if the player has seen the prolog
		if is_seen_prolog():
			LoadManager.load_scene("res://scenes/map/green_garden.tscn", "res://scenes/loading/sideways.tscn")
			AudioAssets.stop_music()
			can_pressed = false
		else:
			LoadManager.load_scene("res://scenes/ui/ui_prolog.tscn", "res://scenes/loading/sideways.tscn")
			AudioAssets.stop_music()
			can_pressed = false

# load the option scene, when option button pressed
func _on_exit_button_pressed() -> void:
	get_tree().quit()

# improve with new ui in section option
func _on_option_button_pressed() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_selected, -50)

	set_buttons_focus(false)
	sound_button.grab_focus()
	ui_option.visible = true
	ui_option.can_back = true
	animation_option.play("in")
	await animation_option.animation_finished

func _on_start_button_focus_entered() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -60)

func _on_option_button_focus_entered() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -60)

func _on_exit_button_focus_entered() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -60)

func set_buttons_focus(can_focus: bool) -> void:
	start_button.focus_mode = Control.FOCUS_ALL if can_focus else Control.FOCUS_NONE
	option_button.focus_mode = Control.FOCUS_ALL if can_focus else Control.FOCUS_NONE
	exit_button.focus_mode = Control.FOCUS_ALL if can_focus else Control.FOCUS_NONE

func _on_option_closed() -> void:
	set_buttons_focus(true)
	option_button.grab_focus()

func is_seen_prolog() -> bool:
	var config = ConfigFile.new()
	var seen_prolog = config.load("user://player_config_prolog.cfg")
	if seen_prolog == OK:
		return config.get_value("prolog", "seen", false)
	return false
