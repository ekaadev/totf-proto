extends CanvasLayer

signal loading_screen_has_full_coverage

@onready var animation: AnimationPlayer = $AnimationLoading
@onready var progress_bar : ProgressBar = $ProgressBar


func _update_progress_bar(new_value: float) -> void:
	progress_bar.set_value_no_signal(new_value * 100) 

func _start_outro_animation() -> void:
	animation.play("end_load")
	await Signal(animation, "animation_finished")
	self.queue_free()