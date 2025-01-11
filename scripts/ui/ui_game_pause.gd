extends CanvasLayer

@onready var timer = $Timer
@onready var pause_animation = $PauseAnimation
@onready var resume_button = $MarginContainer/HBoxContainer/VBoxContainer/ResumeButton
@onready var info_label = $MarginContainer3/VBoxContainer/InformationLabel

func _ready() -> void:
	resume_button.grab_focus()

func _on_timer_timeout() -> void:
	pause_animation.play("pause_in")
	await pause_animation.animation_finished
	timer.stop()
	# $PauseAnimation.play("pause_out")
	# await $PauseAnimation.animation_finished

func _on_resume_button_focus_entered() -> void:
	info_label.text = "INFO: Resume the game"

func _on_goto_main_menu_button_focus_entered() -> void:
	info_label.text = "INFO: Go back to the main menu"