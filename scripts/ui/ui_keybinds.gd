extends CanvasLayer

@onready var layout_keybinds = $MarginContainer
@onready var owner_entity = owner
@onready var state = owner.get_node("StateMachine")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if state.current_node_state_name == "idle" || state.current_node_state_name == "basicattack" || state.current_node_state_name == "slashattack":
		ui_keybind_idle()
	else:
		ui_keybind_not_idle()

func ui_keybind_idle() -> void:
	var tween = create_tween()
	tween.tween_property(
		layout_keybinds, "position:y", 658, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.05)
	await tween.finished

func ui_keybind_not_idle() -> void:
	var tween = create_tween()
	tween.tween_property(
		layout_keybinds, "position:y", layout_keybinds.global_position.y + 62, 0.5
	).set_ease(Tween.EASE_OUT).set_delay(0.05)
	await tween.finished