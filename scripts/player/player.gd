class_name Player
extends CharacterBody2D

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
var player_direction: Vector2

@onready var footstep_sfx = $FootstepsPlayerSFX
@onready var gpu_particles = $GPUParticles2D
# UI HealthBar
@onready var health_bar = $"UIComponents/HealthBar"
# Hurtbox Component
@onready var hurtbox = $"HurtboxComponent/CollisionShape2D"

# Movement & Animation
func _physics_process(_delta):
	update_sfx()

func update_sfx():
#	check, apakah player bergerak
	if velocity != Vector2.ZERO:
#		jika bergerak, check apakah time_left nya kurang dari 0
		if $FootstepTimer.time_left <= 0:
			footstep_sfx.pitch_scale = randf_range(0.8, 1.2)
			footstep_sfx.play()
			$FootstepTimer.start(0.4)

# find component health from player and decrease the health with damage from enemy
func take_damage(damage: int) -> void:
	find_child("HealthComponent").health -= damage

# find component stamina from player and decrease the stamina with stamina from action
func take_stamina(stamina: int) -> void:
	find_child("StaminaPlayerComponent").stamina -= stamina

func set_off_health_component() -> void:
	hurtbox.call_deferred("set_disabled", true)
	owner.find_child("StateMachine").transition_to("Death")

func increase_defense() -> void:
	pass
