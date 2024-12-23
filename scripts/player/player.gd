class_name Player
extends CharacterBody2D

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
var player_direction: Vector2

@onready var footstep_sfx = $FootstepsPlayerSFX
@onready var gpu_particles = $GPUParticles2D

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
	find_child("HealthPlayerComponent").health -= damage

# find component stamina from player and decrease the stamina with stamina from action
func take_stamina(stamina: int) -> void:
	find_child("StaminaPlayerComponent").stamina -= stamina