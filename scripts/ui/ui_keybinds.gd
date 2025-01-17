extends CanvasLayer

@onready var layout_keybinds = $MarginContainer
@onready var owner_entity = owner
@onready var state = owner.get_node("StateMachine")
@onready var map_name = owner.get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	if map_name.get_name() != "BloodForestDesert":
		if state.current_node_state_name.to_lower() == "walk":
			ui_keybind_not_idle()
		else:
			ui_keybind_idle()
	else:
		ui_keybind_idle()
	
func ui_keybind_idle() -> void:
	var tween = create_tween()
	tween.tween_property(
		layout_keybinds, "position:y", 658, 0.5
	).set_ease(Tween.EASE_IN_OUT).set_delay(0.15)
	await tween.finished

func ui_keybind_not_idle() -> void:
	var tween = create_tween()
	tween.tween_property(
		layout_keybinds, "position:y", layout_keybinds.global_position.y + 62, 0.5
	).set_ease(Tween.EASE_OUT_IN).set_delay(0.5)
	await tween.finished