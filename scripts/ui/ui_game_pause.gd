extends CanvasLayer

@onready var pause_animation = $PauseAnimation
@onready var resume_button = $MarginContainer/HBoxContainer/VBoxContainer/ResumeButton
@onready var info_label = $MarginContainer3/VBoxContainer/InformationLabel
@onready var ui_transition_sideways = $UITransitionSideways
@onready var transition_sideways = $UITransitionSideways/SceneTransistion/AnimationPlayer

var can_pressed = true

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("pause"):
			_on_resume_button_pressed()

func _on_resume_button_focus_entered() -> void:
	info_label.text = "INFO: Resume the game"
	
func _on_goto_main_menu_button_focus_entered() -> void:
	info_label.text = "INFO: Go back to the main menu"

func _on_resume_button_pressed() -> void:
	pause_animation.play("pause_out")
	await pause_animation.animation_finished
	visible = false
	get_tree().paused = false

func _on_main_menu_button_pressed() -> void:

	if can_pressed:
		LoadManager.load_scene("res://scenes/ui/user_interface_main_menu.tscn", "res://scenes/loading/sideways.tscn")
		get_tree().paused = false
		can_pressed = false