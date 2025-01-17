extends CanvasLayer

const WINDOW_MODES = [
	DisplayServer.WINDOW_MODE_WINDOWED,
	DisplayServer.WINDOW_MODE_FULLSCREEN
]

@onready var resolution_option = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/OptionButton
@onready var window_mode_option = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/OptionButton
@onready var vsync_check = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/CheckButton

var option_group_scene: PackedScene
var resolutions = [
	Vector2i(1280, 720),
	Vector2i(1366, 768),
	Vector2i(1600, 900),
	Vector2i(1920, 1080)
]

func _ready() -> void:
	resolution_option.connect("item_selected", Callable(self, "_on_resolution_option_item_selected"))
	window_mode_option.connect("item_selected", Callable(self, "_on_window_mode_option_item_selected"))
	vsync_check.connect("toggled", Callable(self, "_on_vsync_check_toggled"))

	# Connect signal
	DisplayManager.settings_changed.connect(_on_display_settings_changed)

	# Setup window mode options first
	window_mode_option.add_item("Windowed")
	window_mode_option.add_item("Fullscreen")
	
	# Setup resolution options
	for resolution in resolutions:
		resolution_option.add_item("%dx%d" % [resolution.x, resolution.y])
	
	# Set current values
	resolution_option.select(resolutions.find(DisplayManager.current_resolution))
	window_mode_option.select(WINDOW_MODES.find(DisplayManager.current_window_mode))
	vsync_check.button_pressed = DisplayManager.vsync_enabled

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		_on_back_button_pressed()

func _on_resolution_option_item_selected(index: int) -> void:
	DisplayManager.current_resolution = resolutions[index]

func _on_window_mode_option_item_selected(index: int) -> void:
	# Debug
	print("Changing window mode to: ", WINDOW_MODES[index]) 
	var new_mode = WINDOW_MODES[index]
	DisplayServer.window_set_mode(new_mode)  # Direct window mode change
	DisplayManager.current_window_mode = new_mode
	
func _on_vsync_check_toggled(button_pressed: bool) -> void:
	DisplayManager.vsync_enabled = button_pressed

func _on_back_button_pressed() -> void:
	AudioAssets.play_sfx(AudioAssets.menu_cancel, -50)

	LoadManager.load_scene("res://scenes/ui/option_group.tscn", "res://scenes/loading/sideways.tscn")

func _on_display_settings_changed() -> void:
	# Debug
	print("Settings changed, current mode: ", DisplayManager.current_window_mode)  
	# Update UI elements when settings change
	resolution_option.select(resolutions.find(DisplayManager.current_resolution))
	window_mode_option.select(WINDOW_MODES.find(DisplayManager.current_window_mode))
	vsync_check.button_pressed = DisplayManager.vsync_enabled