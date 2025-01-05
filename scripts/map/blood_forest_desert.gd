extends Node2D

signal notification_energy_collected(energy: int)

@export var beast_scene: PackedScene

@onready var state_player = $Player/StateMachine
@onready var ui_scene_transition = $UITransitionSideways
@onready var transition = $UITransitionSideways/SceneTransistion/AnimationPlayer
@onready var energy_label = $HUDGameLevel/MarginContainer/HBoxContainer/HBoxContainer/EnergyLabel
@onready var wave_label = $HUDGameLevel/MarginContainer2/HBoxContainer/WaveLabel
@onready var wave_timer_label = $HUDGameLevel/MarginContainer2/HBoxContainer2/WaveTimerLabel
@onready var wave_timer = $WaveTimer
@onready var notification_label = $HUDGameLevel/MarginContainer3/PanelContainer/MarginContainer/HBoxContainer/ToastEnergyLabel
@onready var container_notification = $HUDGameLevel/MarginContainer3

var counter_energy: int = 0
var counter_wave: int = 1
var wait_timer = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	notification_energy_collected.connect(_on_notification_energy_collected)

	ui_scene_transition.visible = true
	transition.play("rect_out")
	await transition.animation_finished
	ui_scene_transition.visible = false

func _process(_delta: float) -> void:
	wait_timer = wave_timer.wait_time

	var time_left = wave_timer.time_left
	wave_timer_label.text = str(snapped(time_left, 1))

	var temp_energy = convert_energy_to_string(counter_energy)
	energy_label.text = temp_energy

	var temp_wave = convert_wave_to_string(counter_wave)
	wave_label.text = "Wave " + temp_wave


func _on_beast_add_energy() -> void:
	var beast_energy = 1
	counter_energy += beast_energy
	emit_signal("notification_energy_collected", beast_energy)

func _on_beast_timer_timeout() -> void:
	if state_player.current_node_state_name != "death" and wave_timer.time_left > 0:
		var new_beast = beast_scene.instantiate()

		# IMPROVE POSITION WITH RANDOM POSITION
		new_beast.position = Vector2(607, 96)

		new_beast.connect("add_energy", Callable(self, "_on_beast_add_energy"))
		add_child(new_beast)

func convert_energy_to_string(energy: int) -> String:
	return str(energy)

func convert_wave_to_string(wave: int) -> String:
	return str(wave)

func _on_wave_timer_timeout() -> void:
	if state_player.current_node_state_name == "death":
		wave_timer.stop()
	else:
		wave_timer.stop()
		counter_wave += 1
		wave_timer.wait_time = wait_timer + 5
		wave_timer.start()

func _on_notification_energy_collected(energy: int) -> void:
	notification_label.text = "+" + str(energy)

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
		0.5  # Duration
	).set_ease(Tween.EASE_OUT_IN)

	# Fade out notification
	tween.tween_property(
		container_notification,
		"modulate:a",
		0,  # Fully transparent
		0.5  # Duration
	).set_ease(Tween.EASE_OUT).set_delay(1)

	await tween.finished

