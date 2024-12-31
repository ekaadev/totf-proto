extends Node2D

@onready var transition = $CanvasLayer/SceneTransistion/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer.visible = true
	transition.play("rect_out")
	await transition.animation_finished
	$CanvasLayer.visible = false