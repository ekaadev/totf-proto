extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var flame_animated_sprite = $AnimatedSprite2D

var toggle = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self, "_toggle_flame")

func _toggle_flame():
	if !toggle:
		flame_animated_sprite.play("idle_on")
		toggle = true
	else:
		flame_animated_sprite.play("idle_off")
		toggle = false
