extends CharacterBody2D

@onready var player = get_parent().find_child("Player")
@onready var sprite = $AnimatedSprite2D
@onready var healthComponent = $HealthComponentNew
@onready var hitbox = $HitboxComponent/CollisionShape2D
@onready var playerDetection = $PlayerDetection/CollisionShape2D

var playerDetectionCooldown = 0

@onready var state = $EnemyStateMachine
@onready var STATE_FOLLOW = $EnemyStateMachine/Follow
@onready var STATE_ATTACK = $EnemyStateMachine/Attack
@onready var STATE_DEATH = $EnemyStateMachine/Death
@onready var STATE_HURT = $EnemyStateMachine/Hurt

@export var maxHealth = 50

var direction: Vector2

var dirArray = [
	Vector2(-1, 0),  # left
	Vector2(-1, 1),  # down-left
	Vector2(0, 1),   # down
	Vector2(1, 1),   # down-right
	Vector2(1, 0),   # right
	Vector2(1, -1),  # up-right
	Vector2(0, -1),  # up
	Vector2(-1, -1), # up-left
]

func _ready() -> void:
	healthComponent.maxHealth = maxHealth
	
	randomize()

func _process(delta: float) -> void:
	if sprite.get_frame() > 1 and sprite.get_frame() < 5 and sprite.animation == "attack_side":
		hitbox.disabled = false
	else:
		hitbox.disabled = true
	
	if state.current_state == STATE_FOLLOW:
		var distance = sqrt((player.position.x - position.x) ** 2 + (player.position.y - position.y) ** 2)
		
		if distance > 2:
			direction = (player.position - position).normalized()
		else:
			direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * 200
	move_and_collide(velocity * delta)

func take_damage(damage: int) -> void:
	healthComponent.setHealth(healthComponent.getHealth() - damage)
