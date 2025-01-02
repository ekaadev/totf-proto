extends CharacterBody2D

# UI HealthBar
@onready var health_bar = $"UIComponents/HealthBar"
# Hurtbox Component
@onready var hurtbox = $"HurtboxComponent/CollisionShape2D"
@onready var player = get_parent().find_child("Player")
@onready var sprite = $Sprite2D
@onready var damage_number_origin = $DamageNumbersOrigin
@onready var hit_animation = $HitAnimation

@export var current_level: float = 0.1

var direction: Vector2

# ready function
# set physics process to false
func _ready() -> void:
	set_physics_process(false)

# process function
# check the player position and set the direction based on the player position
# flip the sprite based on the direction
func _process(_delta: float) -> void:
	direction = player.position - position

	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

# physics process function
# set the velocity based on the direction
# move and collide the player
func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * 100

	# Moves the body along the vector `motion` and tries to collide it with the environment.
	# 
	# Parameters:
	# - `motion`: A Vector2 representing the movement vector.
	# - `collider`: An optional object to store collision information.
	# 
	# Returns:
	# - A Vector2 representing the remaining motion after collision.
	move_and_collide(velocity * delta)

func get_current_level() -> float:
	return current_level

# take damage function
# find the health component from the enemy and decrease the health with the damage from the player
func take_damage(total_damage: float) -> void:
	hit_animation.play("hit_flash")
	DamageNumbers.display_damage_number(total_damage, damage_number_origin.global_position)
	find_child("HealthComponent").health -= total_damage - find_child("HealthComponent").DEF

# Set the progress bar to invisible
# Set the hurtbox to disabled
# Change the state to Death
func set_off_health_component() -> void:
	health_bar.visible = false
	hurtbox.call_deferred("set_disabled", true)
	owner.find_child("EnemyStateMachine").change_state("Death")

func increase_defense() -> void:
	find_child("HealthComponent").DEF = 5
