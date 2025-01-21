extends Node2D

@onready var ui_pause = $UIGamePause
@onready var animation_pause = $UIGamePause/PauseAnimation
@onready var resume_button = $UIGamePause/MarginContainer/HBoxContainer/VBoxContainer/ResumeButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioAssets.play_music(AudioAssets.green_garden_music, -65.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Pause the game
	if Input.is_action_just_pressed("pause"):
		_on_pause_button_pressed()

# On pause button pressed
func _on_pause_button_pressed() -> void:
	resume_button.grab_focus()
	get_tree().paused = true
	ui_pause.visible = true
	animation_pause.play("pause_in")
	await animation_pause.animation_finished

