extends Node
class_name NodeStateMachine

@export var initial_node_state : NodeState

var node_states : Dictionary = {}
var current_node_state : NodeState
var current_node_state_name : String

# ready function
# loop through all children and add them to the dictionary
# connect the transition signal to the transition_to function
# if initial_node_state is not null, call the _on_enter function and set the current_node_state
func _ready() -> void:
	for child in get_children():
		if child is NodeState:
			node_states[child.name.to_lower()] = child
			child.transition.connect(transition_to)
	
	if initial_node_state:
		initial_node_state._on_enter()
		current_node_state = initial_node_state

# process function
# if current_node_state is not null, call the _on_process function
func _process(delta : float) -> void:
	if current_node_state:
		current_node_state._on_process(delta)

# physics process function
# if current_node_state is not null, call the _on_physics_process function
# call the _on_next_transitions function
func _physics_process(delta: float) -> void:
	if current_node_state:
		current_node_state._on_physics_process(delta)
		current_node_state._on_next_transitions()

# transition_to function
# check if the node_state_name is the same as the current_node_state name, if yes, return
# get the new_node_state from the dictionary
# if new_node_state is null, return
# if current_node_state is not null, call the _on_exit function
# call the _on_enter function for the new_node_state

# FOR DEBUGGING
# set the current_node_state to the new_node_state
# set the current_node_state_name to the new_node_state name
# print the current_node_state_name
func transition_to(node_state_name : String) -> void:
	if node_state_name == current_node_state.name.to_lower():
		return
	
	var new_node_state = node_states.get(node_state_name.to_lower())
	
	if !new_node_state:
		return
	
	if current_node_state:
		current_node_state._on_exit()
	
	new_node_state._on_enter()
	
	current_node_state = new_node_state
	current_node_state_name = current_node_state.name.to_lower()
	print("Current State: ", current_node_state_name)
