extends Node
class_name EnemyState

@onready var player = owner.get_parent().find_child("Player")
@onready var animation_player = owner.find_child("AnimationPlayer")

# turn off physics process
func _ready() -> void:
	set_physics_process(false)
 
# turn on physics process when entering state
func enter():
	set_physics_process(true)

# turn off physics process when exiting state
func exit():
	set_physics_process(false)

# traansition will have conditions to change state
func transition():
	pass

# transition will be running on physics process
func _physics_process(_delta: float) -> void:
	transition()
	print(name)
