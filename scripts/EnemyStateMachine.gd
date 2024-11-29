extends Node2D

var current_state: EnemyState
var previous_state: EnemyState

# initialize state machine
func _ready() -> void:
	current_state = get_child(0) as EnemyState
	previous_state = current_state
	current_state.enter()

func change_state(state):
	# enter new state
	current_state = find_child(state) as EnemyState
	current_state.enter()

	# exit previous state
	previous_state.exit()
	previous_state = current_state
