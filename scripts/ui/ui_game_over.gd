extends CanvasLayer

@onready var button_goto_green_garden = $MarginContainer/VBoxContainer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/GotoGreenGardenButton

var main_menu_scene = preload("res://scenes/ui/user_interface_main_menu.tscn")
var green_garden_scene = preload("res://scenes/map/green_garden.tscn")

var can_pressed = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioAssets.play_music(AudioAssets.menu_music, -65.0)

	button_goto_green_garden.grab_focus()

# load the green garden scene when the button is pressed
func _on_goto_green_garden_button_pressed() -> void:
	
	if can_pressed:
		AudioAssets.play_sfx(AudioAssets.menu_selected, -50)
		LoadManager.load_scene("res://scenes/map/green_garden.tscn", "res://scenes/loading/fade.tscn")
		AudioAssets.stop_music()
		can_pressed = false

# load the main menu scene when the button is pressed
func _on_goto_main_menu_button_pressed() -> void:

	if can_pressed:
		AudioAssets.play_sfx(AudioAssets.menu_selected, -50)
		LoadManager.load_scene("res://scenes/ui/user_interface_main_menu.tscn", "res://scenes/loading/fade.tscn")
		AudioAssets.stop_music()
		can_pressed = false

func _on_goto_green_garden_button_focus_entered() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -60) 

func _on_goto_main_menu_button_focus_entered() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cursor, -60) 
