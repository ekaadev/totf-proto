extends CanvasLayer

@onready var resume_button = $MarginContainer/HBoxContainer/VBoxContainer/ResumeButton

func _ready() -> void:
	resume_button.grab_focus()

func _on_timer_timeout() -> void:
	$PauseAnimation.play("pause_in")
	await $PauseAnimation.animation_finished
	$Timer.stop()
	# $PauseAnimation.play("pause_out")
	# await $PauseAnimation.animation_finished