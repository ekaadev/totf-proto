extends CharacterBody2D
 
@onready var player = get_parent().get_node("playerTest") # Pastikan path benar
@onready var animated_sprite = $AnimatedSprite2D
@onready var progress_bar = $UI/Healthbar
 
var direction : Vector2

func _ready():
	set_physics_process(false)  # Physics dihentikan hingga diperlukan
 
func _process(_delta):
	if player:  # Update arah menghadap berdasarkan posisi player
		if player.position.x < position.x:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
 
func _physics_process(delta):
	if player:  # Update direction dan gerakan monster
		direction = (player.position - position).normalized()
		velocity = direction * 80  # Sesuaikan kecepatan jika perlu
		move_and_collide(velocity * delta)
