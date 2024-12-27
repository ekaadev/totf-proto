class_name Player
extends CharacterBody2D

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
# UI HealthBar
@onready var health_bar = $"UIComponents/HealthBar"
# Hurtbox Component
@onready var hurtbox = $"HurtboxComponent/CollisionShape2D"
@onready var footstep_sfx = $FootstepsPlayerSFX
@onready var gpu_particles = $GPUParticles2D
@onready var state = $StateMachine
# attribute for player
@export var current_level: float = 0.1
var player_direction: Vector2

# Movement & Animation
func _physics_process(_delta):
	update_sfx()

func update_sfx():
#	check, apakah player bergerak
	if state.current_node_state_name == "walk":
#		jika bergerak, check apakah time_left nya kurang dari 0
		if $FootstepTimer.time_left <= 0:
			footstep_sfx.pitch_scale = randf_range(0.8, 1.2)
			footstep_sfx.play()
			$FootstepTimer.start(0.4)

func get_current_level() -> float:
	return current_level

# find component health from player and decrease the health with damage from enemy
func take_damage(total_damage: float) -> void:
	find_child("HealthComponent").health -= total_damage

# find component stamina from player and decrease the stamina with stamina from action
func take_stamina(stamina: int) -> void:
	find_child("StaminaPlayerComponent").stamina -= stamina

func set_off_health_component() -> void:
	hurtbox.call_deferred("set_disabled", true)
	owner.find_child("StateMachine").transition_to("Death")

func increase_defense() -> void:
	pass