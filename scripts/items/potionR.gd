extends Area2D

@export var healthRestore = 20

@onready var sprite = $AnimatedSprite2D
@onready var player = get_parent().find_child("Player")

func _ready() -> void:
	sprite.play("default")
	
	self.connect("body_entered", _onPlayerEntered)

func _process(_delta: float) -> void:
	pass

func _onPlayerEntered(body: Node2D) -> void:
	if body.name != "Player":
		return
	
	var healthComponent = body.find_child("HealthComponent")
	
	if healthComponent.health >= healthComponent.enity_max_health:
		return
	
	# heal the player
	if body.has_method("heal"):
		body.heal(healthRestore)
		self.queue_free()
