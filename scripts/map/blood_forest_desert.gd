extends Node2D

@export var beast_scene: PackedScene

@onready var state_player = $Player/StateMachine
@onready var ui_scene_transition = $UITransitionSideways
@onready var transition = $UITransitionSideways/SceneTransistion/AnimationPlayer
@onready var energy_label = $HUDGameLevel/MarginContainer/HBoxContainer/HBoxContainer/EnergyLabel

var counter_energy: int = 0
var counter_wave: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_scene_transition.visible = true
	transition.play("rect_out")
	await transition.animation_finished
	ui_scene_transition.visible = false

func _process(_delta: float) -> void:
	var temp_energy = convert_energy_to_string(counter_energy)
	energy_label.text = "Energy " + temp_energy

func _on_beast_add_energy() -> void:
	counter_energy += 1

func _on_beast_timer_timeout() -> void:
	if state_player.current_node_state_name != "death":
		var new_beast = beast_scene.instantiate()

		# IMPROVE POSITION WITH RANDOM POSITION
		new_beast.position = Vector2(607, 96)

		new_beast.connect("add_energy", Callable(self, "_on_beast_add_energy"))
		add_child(new_beast)
		

func convert_energy_to_string(energy: int) -> String:
	return str(energy)