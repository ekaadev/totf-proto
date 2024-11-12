extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

# test
@onready var progess_bar = $CanvasLayer/FlameBar

const base_text = "[E] to "

var active_areas = []
var can_interact = true

# test
var is_holding_interact = false
var hold_time = 0.0
var hold_duration = 3.0

func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)
		
func _process(delta: float) -> void:
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()
		
#		test
		if is_holding_interact:
			hold_time += delta
			progess_bar.value = hold_time / hold_duration * 100
			if hold_time >= hold_duration:
				is_holding_interact = false
				hold_time = 0.0
				progess_bar.hide()
				active_areas[0].interact.call()
				can_interact = true
				
	else:
		label.hide()
		
#		test
		progess_bar.hide()
		hold_time = 0.0
		

func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			#can_interact = false
			#label.hide()
			
#			test
			var current_area = active_areas[0]
			if current_area.interaction_type == "hold":
				is_holding_interact = true
				hold_time = 0.0
				progess_bar.show()
			elif current_area.interaction_type == "tap":
				can_interact = false
				label.hide()
				await active_areas[0].interact.call()
				can_interact = true
			
			#await active_areas[0].interact.call()
			#can_interact = true
				
	elif event.is_action_released("interact") && is_holding_interact:
		is_holding_interact = false
		hold_time = 0.0
		progess_bar.hide()
