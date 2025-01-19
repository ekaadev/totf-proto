extends Control

@onready var ui_transition_fade = $UITransitionFade
@onready var transition_fade = $UITransitionFade/GameOverAnimation
@onready var start_button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/StartButton
@onready var option_button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/OptionButton
@onready var exit_button = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/ExitButton
@onready var ui_option = $UIOption
@onready var animation_option = $UIOption/OptionAnimation

var can_pressed = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_option.connect("option_closed", Callable(self, "_on_option_closed"))

	AudioAssets.play_music(AudioAssets.menu_music, -60.0)
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
		LoadManager.load_scene("res://scenes/map/green_garden.tscn", "res://scenes/loading/sideways.tscn")
		AudioAssets.stop_music()
		can_pressed = false

# load the option scene, when option button pressed
func _on_exit_button_pressed() -> void:
	get_tree().quit()

# improve with new ui in section option
func _on_option_button_pressed() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_selected, -50)

	set_buttons_focus(false)
	ui_option.visible = true
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
	start_button.grab_focus()
