extends CanvasLayer

@onready var ui_scene_transition_fade = $UITransitionFade
@onready var transition_fade = $UITransitionFade/GameOverAnimation
@onready var button_goto_green_garden = $MarginContainer/VBoxContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/GotoGreenGardenButton

var main_menu_scene = preload("res://scenes/ui/user_interface_main_menu.tscn")
var green_garden_scene = preload("res://scenes/map/green_garden.tscn")

var can_pressed = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_goto_green_garden.grab_focus()

	# ui_scene_transition_fade.visible = true
	# transition_fade.play("fade_out")
	# await transition_fade.animation_finished
	# ui_scene_transition_fade.visible = false

func _on_goto_green_garden_button_pressed() -> void:
	
	if can_pressed:
		LoadManager.load_scene("res://scenes/map/green_garden.tscn", "res://scenes/loading/fade.tscn")
		can_pressed = false

	# ui_scene_transition_fade.visible = true
	# transition_fade.play("fade_in")
	# await get_tree().create_timer(0.5).timeout
	# await transition_fade.animation_finished
	# call_deferred("_change_scene_to_green_garden")

func _on_goto_main_menu_button_pressed() -> void:

	if can_pressed:
		LoadManager.load_scene("res://scenes/ui/user_interface_main_menu.tscn", "res://scenes/loading/fade.tscn")
		can_pressed = false

	# ui_scene_transition_fade.visible = true
	# transition_fade.play("fade_in")
	# await get_tree().create_timer(0.5).timeout
	# await transition_fade.animation_finished
	# call_deferred("_change_scene_to_main_menu")

func _change_scene_to_main_menu() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)

func _change_scene_to_green_garden() -> void:
	get_tree().change_scene_to_packed(green_garden_scene)
