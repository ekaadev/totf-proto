extends Node2D

@onready var ui_scene_transition_sideways = $UITransitionSideways
@onready var transition_sideways = $UITransitionSideways/SceneTransistion/AnimationPlayer
@onready var ui_pause = $UIGamePause
@onready var animation_pause = $UIGamePause/PauseAnimation
@onready var resume_button = $UIGamePause/MarginContainer/HBoxContainer/VBoxContainer/ResumeButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_on_pause_button_pressed()
		
func _on_pause_button_pressed() -> void:
	resume_button.grab_focus()
	get_tree().paused = true
	ui_pause.visible = true
	animation_pause.play("pause_in")
	await animation_pause.animation_finished

