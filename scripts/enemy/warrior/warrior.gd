extends CharacterBody2D

@onready var player = get_parent().find_child("Player")

@onready var hurtbox = $HurtboxComponent/CollisionShape2D
@onready var sprite = $Sprite2D
@onready var stateMachine = $EnemyStateMachine

@export var current_level: float = 0.1

var direction: Vector2

func _ready() -> void:
	set_physics_process(false)

func _process(_delta: float) -> void:
	direction = player.position - position

	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * 100
	move_and_collide(velocity * delta)

func take_damage(damage: int) -> void:
	find_child("HealthComponent").health -= damage - find_child("HealthComponent").DEF

func get_current_level() -> float:
	return current_level

func set_off_health_component() -> void:
	hurtbox.call_deferred("set_disabled", true)
	stateMachine.change_state("Death")
	emit_signal("add_energy")
