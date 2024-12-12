extends StaticBody2D

@onready var interaction_area = $InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_portal")

func _on_portal():
	print("On portal")
