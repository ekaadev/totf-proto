extends Node2D

@onready var ui_scene_transition = $UITransitionSideways
@onready var transition = $UITransitionSideways/SceneTransistion/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_scene_transition.visible = true
	transition.play("rect_out")
	await transition.animation_finished
	ui_scene_transition.visible = false
