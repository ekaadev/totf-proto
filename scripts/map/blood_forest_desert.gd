extends Node2D

signal notification_energy_collected(energy: int)
signal player_game_over

@export var beast_scene: PackedScene
@export var spider_scene: PackedScene
@export var potion_health: PackedScene
# @export var max_enemies: int

@onready var state_player = $Player/StateMachine
@onready var energy_label = $HUDGameLevel/MarginContainer/HBoxContainer/HBoxContainer/EnergyLabel
@onready var wave_label = $HUDGameLevel/MarginContainer2/HBoxContainer/WaveLabel
@onready var wave_timer_label = $HUDGameLevel/MarginContainer2/HBoxContainer2/WaveTimerLabel
@onready var wave_timer = $WaveTimer
@onready var notification_label = $HUDGameLevel/MarginContainer3/PanelContainer/MarginContainer/HBoxContainer/ToastEnergyLabel
@onready var container_notification = $HUDGameLevel/MarginContainer3
@onready var ui_pause = $UIGamePause
@onready var animation_pause = $UIGamePause/PauseAnimation
@onready var resume_button = $UIGamePause/MarginContainer/HBoxContainer/VBoxContainer/ResumeButton
@onready var beast_spawn = $BeastPath/BeastSpawnLocation
@onready var spider_spawn = $SpiderPath/SpiderSpawnLocation
@onready var potion_health_spawn = $HealthPotionPath/HealthPotionSpawnLocation

var counter_energy: int = 0
var counter_wave: int = 1
var wait_timer = 30
var notification_queue: Array = []
var is_showing_notification: bool = false
var has_emitted_game_over: bool = false
# var current_enemies: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioAssets.play_music(AudioAssets.blood_forest_music, -65.0)

	# Connect signals
	# - enegy collected signal
	# - game over signal
	notification_energy_collected.connect(_on_notification_energy_collected)
	player_game_over.connect(on_player_game_over)

	print("Blood Forest Desert Scene Loaded")

	# Start the wave timer
	wave_timer.start()

func _process(_delta: float) -> void:
	# Pause the game
	# Can pause the game with escape key
	if Input.is_action_just_pressed("pause"):
		_on_pause_button_pressed()

	# Update the variables wait timer
	# wait_timer used to add time to the wave timer
	wait_timer = wave_timer.wait_time

	# Update the wave timer label
	var time_left = wave_timer.time_left
	if time_left < 3:
		wave_timer_label.text = str(snapped(time_left, 0.1)) + " SEC"
	else:
		wave_timer_label.text = str(snapped(time_left, 1)) + " SEC"

	# Update the energy label
	var temp_energy = convert_energy_to_string(counter_energy)
	energy_label.text = temp_energy

	# Update the wave label
	var temp_wave = convert_wave_to_string(counter_wave)
	wave_label.text = "Wave " + temp_wave

	# Check if the player is dead
	# Emit the game over signal
	if state_player.current_node_state_name == "death" and !has_emitted_game_over:
		has_emitted_game_over = true
		emit_signal("player_game_over")

# Beast spawn
func _on_beast_timer_timeout() -> void:
	if state_player.current_node_state_name != "death" and wave_timer.time_left > 0:
		var mob_spawn_location = beast_spawn
		mob_spawn_location.progress_ratio = randf()

		var new_beast = beast_scene.instantiate()
		new_beast.position = mob_spawn_location.position

		new_beast.connect("add_energy", Callable(self, "_on_beast_add_energy"))
		add_child(new_beast)

# Spider spawn
func _on_spider_timer_timeout() -> void:
	if state_player.current_node_state_name != "death" and wave_timer.time_left > 0:
		var mob_spawn_location = spider_spawn
		mob_spawn_location.progress_ratio = randf()

		var new_spider = spider_scene.instantiate()
		new_spider.position = mob_spawn_location.position

		new_spider.connect("add_energy", Callable(self, "_on_spider_add_energy"))
		add_child(new_spider)

# Health potion spawn
func _on_health_potion_timer_timeout() -> void:
	if state_player.current_node_state_name != "death" and wave_timer.time_left > 0:
		var spawn_location = potion_health_spawn
		spawn_location.progress_ratio = randf()

		var new_potion = potion_health.instantiate()
		new_potion.position = spawn_location.position

		add_child(new_potion)

# Convert energy to string
func convert_energy_to_string(energy: int) -> String:
	return str(energy)

# Convert wave to string
func convert_wave_to_string(wave: int) -> String:
	return str(wave)

# Wave timer timeout
# Stop the wave timer if the player is dead
# Increase the wave counter and add time to the wave timer if the player is alive
func _on_wave_timer_timeout() -> void:
	if state_player.current_node_state_name == "death":
		wave_timer.stop()
	else:
		wave_timer.stop()
		counter_wave += 1
		wave_timer.wait_time = wait_timer + 5
		wave_timer.start()

# Beast add energy
func _on_beast_add_energy() -> void:
	var beast_energy = randi_range(10, 20)
	counter_energy += beast_energy
	notification_queue.append(beast_energy)
	process_notification_queue()

# Spider add energy
func _on_spider_add_energy() -> void:
	var spider_energy = randi_range(1, 4)
	counter_energy += spider_energy
	notification_queue.append(spider_energy)
	process_notification_queue()

# Notification energy collected
func _on_notification_energy_collected(energy: int) -> void:
	notification_label.text = "Energy x " + str(energy)

	# Reset notification position and visibility
	container_notification.position.x = -100
	container_notification.modulate.a = 1.0

	# Create parallel tweens
	var tween = create_tween()
	tween.set_parallel(true)

	# Slide in notification
	tween.tween_property(
		container_notification,
		"position:x",
		2,  # Target position
		0.25  # Duration
	).set_ease(Tween.EASE_IN_OUT)

	# Fade out notification
	tween.tween_property(
		container_notification,
		"modulate:a",
		0,  # Fully transparent
		0.5  # Duration
	).set_ease(Tween.EASE_OUT_IN).set_delay(0.8)

	await tween.finished
	is_showing_notification = false
	process_notification_queue()

# Process notification queue
func process_notification_queue() -> void:
	if is_showing_notification or notification_queue.is_empty():
		return
	
	is_showing_notification = true
	var energy_collected = notification_queue.pop_front()
	emit_signal("notification_energy_collected", energy_collected)

# Player game over
# Load the game over scene
# load scene have 2 parameters
# 1. scene path
# 2. fade path
func on_player_game_over() -> void:
	# Load existing energy
	var existing_energy = load_energy()
	
	# Add current counter to existing
	var total_energy = existing_energy + counter_energy
	
	# Save combined total
	var config = ConfigFile.new()
	config.set_value("energy", "counter_energy", total_energy)
	config.set_value("energy", "energy_collected", counter_energy)
	config.save("user://player_energy.cfg")

	LoadManager.load_scene("res://scenes/ui/ui_game_over.tscn", "res://scenes/loading/fade.tscn")
	AudioAssets.stop_music()

# Pause button pressed
func _on_pause_button_pressed() -> void:
	resume_button.grab_focus()
	get_tree().paused = true
	ui_pause.visible = true
	animation_pause.play("pause_in")
	await animation_pause.animation_finished

func load_energy() -> int:
	var config = ConfigFile.new()
	var energy = 0
	var err = config.load("user://player_energy.cfg")
	if err == OK:
		energy = config.get_value("energy", "counter_energy", 0)  # Default 0 if not found
	
	return energy