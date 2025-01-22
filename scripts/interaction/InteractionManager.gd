extends Node2D

# get the player node
@onready var player = get_tree().get_first_node_in_group("player")
# get the label node
@onready var label = $Label

# get the flame bar node
@onready var progess_bar = $CanvasLayer/FlameBar

# base text for the interaction label
const base_text = "[E] to "

# list of active interaction areas
var active_areas = []
# flag to check if the player can interact with the object
var can_interact = true

# flag to check if the player is holding the interact button
var is_holding_interact = false
# hold time for the interaction
var hold_time = 0.0
# hold duration for the interaction
var hold_duration = 3.0

# Called when the node enters the scene tree for the first time.
func register_area(area: InteractionArea):
	# add the area to the list of active areas if area is not already in the list
	active_areas.push_back(area)

# Called when the node is removed from the scene tree.
func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		# remove the area from the list of active areas
		active_areas.remove_at(index)

func _process(delta: float) -> void:
	if active_areas.size() > 0 && can_interact:
		# sort the active areas based on the distance to the player
		active_areas.sort_custom(_sort_by_distance_to_player)
		# show the interaction label with the action name of the closest area
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 50
		label.global_position.x -= label.size.x / 2
		label.show()
		
		# check if the player is holding the interact button
		if is_holding_interact:
			# update the hold time and progress bar value
			hold_time += delta
			progess_bar.value = hold_time / hold_duration * 100
			if hold_time >= hold_duration:
				# set the flag to false and call the interact function
				is_holding_interact = false
				hold_time = 0.0
				progess_bar.hide()
				active_areas[0].interact.call()
				can_interact = true
				
	else:
		label.hide()
		progess_bar.hide()
		hold_time = 0.0
		
# sort function to sort the active areas based on the distance to the player
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player
	
func _input(event: InputEvent) -> void:
	# check if the player is pressing the interact button and can interact with the object
	if event.is_action_pressed("interact") && can_interact:
		# check if there are active areas
		if active_areas.size() > 0:
			# get the current active area
			var current_area = active_areas[0]
			# check the interaction type of the current area
			# if the interaction type is hold, set the flag to true and show the progress bar
			# if the interaction type is tap, call the interact function
			if current_area.interaction_type == "hold":
				is_holding_interact = true
				hold_time = 0.0
				progess_bar.show()
			elif current_area.interaction_type == "tap":
				can_interact = false
				label.hide()
				await active_areas[0].interact.call()
				can_interact = true
				
	# check if the player released the interact button and is holding the interact button
	elif event.is_action_released("interact") && is_holding_interact:
		is_holding_interact = false
		hold_time = 0.0
		progess_bar.hide()
