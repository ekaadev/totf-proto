class_name NodeState
extends Node

@warning_ignore("unused_signal")
signal transition 

# on process function
# do something in the process function
func _on_process(_delta : float) -> void:
	pass

# on physics process function
# do something in the physics process function
func _on_physics_process(_delta : float) -> void:
	pass

# on next transitions function
# do something in the next transitions function
func _on_next_transitions() -> void:
	pass

# on enter function
# do something in the enter function
func _on_enter() -> void:
	pass

# on exit function
# do something in the exit function
func _on_exit() -> void:
	pass
