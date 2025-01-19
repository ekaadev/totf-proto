extends CanvasLayer

signal in_option
signal option_closed

@onready var master_slider = $MarginContainer2/HBoxContainer/VBoxContainer/HBoxContainer/HSlider
@onready var music_slider = $MarginContainer2/HBoxContainer/VBoxContainer/HBoxContainer2/HSlider
@onready var se_slider = $MarginContainer2/HBoxContainer/VBoxContainer/HBoxContainer3/HSlider

@onready var resolution_option = $MarginContainer3/HBoxContainer/VBoxContainer/HBoxContainer/OptionButton
@onready var window_mode_option = $MarginContainer3/HBoxContainer/VBoxContainer/HBoxContainer2/OptionButton

@onready var animation = $OptionAnimation

const WINDOW_MODES = [
	DisplayServer.WINDOW_MODE_WINDOWED,
	DisplayServer.WINDOW_MODE_FULLSCREEN
]

var resolutions = [
	Vector2i(1280, 720),
	Vector2i(1366, 768),
	Vector2i(1600, 900),
	Vector2i(1920, 1080)
]

var in_sound = false
var in_display = false
var is_animating = false
var current_animation = ""

func _ready() -> void:

	master_slider.value = AudioManager.master_volume
	music_slider.value = AudioManager.music_volume
	se_slider.value = AudioManager.sfx_volume

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

	in_option.connect(_on_option)

func _process(_delta: float) -> void:
	if is_animating:
		return
		
	if in_sound and Input.is_action_just_pressed("ui_cancel"):
		play_animation("sound_out")
		in_sound = false
		
	if in_display and Input.is_action_just_pressed("ui_cancel"):
		play_animation("display_out")
		in_display = false

func _input(event: InputEvent) -> void:
	if is_animating:
		return
		
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel") and !in_sound and !in_display:
			play_animation("out")
			emit_signal("option_closed")

func play_animation(anim_name: String) -> void:
	if is_animating or current_animation == anim_name:
		return
		
	is_animating = true
	current_animation = anim_name
	animation.play(anim_name)
	await animation.animation_finished
	is_animating = false
	current_animation = ""
	
	if anim_name in ["sound_out", "display_out"]:
		emit_signal("in_option")

func _on_sound_button_pressed() -> void:
	if is_animating:
		return
	in_sound = true
	play_animation("sound_in")

func _on_display_button_pressed() -> void:
	if is_animating:
		return
	in_display = true
	play_animation("display_in")

func _on_option() -> void:
	play_animation("option_in")

func _on_master_slider_value_changed(value: float) -> void:
	AudioManager.master_volume = value

func _on_music_slider_value_changed(value: float) -> void:
	AudioManager.music_volume = value

func _on_se_slider_value_changed(value: float) -> void:
	AudioManager.sfx_volume = value

func _on_resolution_option_item_selected(index: int) -> void:
	DisplayManager.current_resolution = resolutions[index]

func _on_window_mode_option_item_selected(index: int) -> void:
	# Debug
	print("Changing window mode to: ", WINDOW_MODES[index]) 
	var new_mode = WINDOW_MODES[index]
	DisplayServer.window_set_mode(new_mode)  # Direct window mode change
	DisplayManager.current_window_mode = new_mode

func _on_display_settings_changed() -> void:
	# Debug
	print("Settings changed, current mode: ", DisplayManager.current_window_mode)  
	# Update UI elements when settings change
	resolution_option.select(resolutions.find(DisplayManager.current_resolution))
	window_mode_option.select(WINDOW_MODES.find(DisplayManager.current_window_mode)) 