extends Area2D
class_name InteractionArea

# action name, nama aksi yang akan dijalankan
@export var action_name: String = "interact"
# interaction type, tipe interaksi pada objel (hold, press)
@export var interaction_type: String = "hold"

var interact: Callable = func():
	pass
	
# Called when the node enters the scene tree for the first time.
func _on_body_entered(_body: Node2D) -> void:
	InteractionManager.register_area(self)

# Called when the node is removed from the scene tree.
func _on_body_exited(_body: Node2D) -> void:
	InteractionManager.unregister_area(self)
