extends Control

# Signals
signal game_update
signal check_unlocks

# Plot States
enum PlotState {
	UNTILLED,
	TILLED,
	PLANTED,
	GROWING1,
	GROWING2,
	GROWING3,
	GROWN
}

# Mapping States to their respective Characters
const STATE_CHARS = {
	PlotState.UNTILLED: "~",
	PlotState.TILLED: "=",
	PlotState.PLANTED: "¤",
	PlotState.GROWING1: "\\",
	PlotState.GROWING2: "|",
	PlotState.GROWING3: "/",
	PlotState.GROWN: "¥"
}

# Current state of the plot
var current_state = PlotState.UNTILLED

@onready var button = $PlotButton

func _ready():
	button.pressed.connect(_on_button_pressed)
	button.text = STATE_CHARS[current_state]
	#  Used Connections
	var main = get_node("/root/Control")
	game_update.connect(main._update_game_labels)
	check_unlocks.connect(main._check_all_unlock_counters)


# Primary Plot Sequence
func _on_button_pressed():
	if _game_paused_check(): return
	print ("Plot " + str(get_index()) + " clicked")
	var original_state = current_state
	match current_state:
		PlotState.UNTILLED:
			if VariableStorage.current_tool == VariableStorage.TOOL_PLOW:
				current_state = PlotState.TILLED
				VariableStorage.plots_clicked += 1
				VariableStorage.plow_used += 1
			else:
				print("Need Plow selected!")
				NotificationManager.show_notification("Wrong Tool","Need Plow selected!")
				return
		PlotState.TILLED:
			if VariableStorage.seeds > 0:
				VariableStorage.seeds -= 1
				current_state = PlotState.PLANTED
				VariableStorage.plots_clicked += 1
			else:
				print("Not enough seeds!")
				NotificationManager.show_notification("Insufficient Resources","Not enough seeds!")
				return
		PlotState.PLANTED:
			if VariableStorage.current_tool == VariableStorage.TOOL_WATERING_CAN:
				if VariableStorage.water > 0:
					VariableStorage.water -= 1
					current_state = PlotState.GROWING1
					VariableStorage.plots_clicked += 1
					VariableStorage.water_used += 1
				else:
					print("Not enough water!")
					NotificationManager.show_notification("Insufficient Resources","Not enough water!")
					return
			else:
				print("Need Watering Can tool selected!")
				NotificationManager.show_notification("Wrong Tool","Need Watering Can tool selected!")
				return
		PlotState.GROWING1:
			if VariableStorage.current_tool == VariableStorage.TOOL_WATERING_CAN:
				if VariableStorage.water > 0:
					VariableStorage.water -= 1
					current_state = PlotState.GROWING2
					VariableStorage.plots_clicked += 1
					VariableStorage.water_used += 1
				else:
					print("Not enough water!")
					NotificationManager.show_notification("Insufficient Resources","Not enough water!")
					return
			else:
				print("Need Watering Can tool selected!")
				NotificationManager.show_notification("Wrong Tool","Need Watering Can tool selected!")
				return
		PlotState.GROWING2:
			if VariableStorage.current_tool == VariableStorage.TOOL_WATERING_CAN:
				if VariableStorage.water > 0:
					VariableStorage.water -= 1
					current_state = PlotState.GROWING3
					VariableStorage.plots_clicked += 1
					VariableStorage.water_used += 1
				else:
					print("Not enough water!")
					NotificationManager.show_notification("Insufficient Resources","Not enough water!")
					return
			else:
				print("Need Watering Can tool selected!")
				NotificationManager.show_notification("Wrong Tool","Need Watering Can tool selected!")
				return
		PlotState.GROWING3:
			if VariableStorage.current_tool == VariableStorage.TOOL_WATERING_CAN:
				if VariableStorage.water > 0:
					VariableStorage.water -= 1
					current_state = PlotState.GROWN
					VariableStorage.plots_clicked += 1
					VariableStorage.water_used += 1
				else:
					print("Not enough water!")
					NotificationManager.show_notification("Insufficient Resources","Not enough water!")
					return
			else:
				print("Need Watering Can tool selected!")
				NotificationManager.show_notification("Wrong Tool","Need Watering Can tool selected!")
				return
		PlotState.GROWN:
			if VariableStorage.current_tool == VariableStorage.TOOL_SCYTHE:
				VariableStorage.crops += 1
				current_state = PlotState.UNTILLED
				VariableStorage.plots_clicked += 1
				VariableStorage.crops_harvested += 1
				if randf() <= 0.15:
					VariableStorage.seeds += 1
					print("Seed Drop!")
					NotificationManager.show_notification("Seed Drop!","A seed has dropped!")
			else:
				print("Need scythe tool selected!")
				NotificationManager.show_notification("Wrong Tool","Need scythe tool selected!")
				return
	if VariableStorage.mkOne_toggle_ON:
		var adjacent_plots_mk_one = get_adjacent_plots_mk_one()
		for mkOne_plot in adjacent_plots_mk_one:
			if mkOne_plot.current_state == original_state:
				try_upgraded_click(mkOne_plot)
				if VariableStorage.mkTwo_toggle_ON:
					var adjacent_plots_mk_two = get_adjacent_plots_mk_two()
					for mkTwo_plot in adjacent_plots_mk_two:
						if mkTwo_plot.current_state == original_state:
							try_upgraded_click(mkTwo_plot)
							if VariableStorage.mkThree_toggle_ON:
								var adjacent_plots_mk_three = get_adjacent_plots_mk_three()
								for mkThree_plot in adjacent_plots_mk_three:
									if mkThree_plot.current_state == original_state:
										try_upgraded_click(mkThree_plot)

	button.text = STATE_CHARS[current_state]
	game_update.emit()
	check_unlocks.emit()


# Adjacent Plot Check
func get_adjacent_plots_mk_one() -> Array:
	var parent = get_parent()
	var my_index = get_index()
	var adjacent = []
    
    # Check left plot
	if my_index > 0:
		adjacent.append(parent.get_child(my_index - 1))
    
    # Check right plot
	if my_index < parent.get_child_count() - 1:
		adjacent.append(parent.get_child(my_index + 1))
        
	return adjacent

# Adjacent Plot Check - MK2 (Vertical)
func get_adjacent_plots_mk_two() -> Array:
	var parent = get_parent()
	var my_index = get_index()
	var adjacent = []
	
	# Check plot above (3 positions back)
	if my_index >= 3:
		adjacent.append(parent.get_child(my_index - 3))
	
	# Check plot below (3 positions forward)
	if my_index < parent.get_child_count() - 3:
		adjacent.append(parent.get_child(my_index + 3))
		
	return adjacent

func get_adjacent_plots_mk_three() -> Array:
	var parent = get_parent()
	var my_index = get_index()
	var adjacent = []
	
	# Check far left plot (-4)
	if my_index >= 4:
		adjacent.append(parent.get_child(my_index - 4))
	
	# Check near left plot (-2)
	if my_index >= 2:
		adjacent.append(parent.get_child(my_index - 2))
	
	# Check near right plot (+2)
	if my_index < parent.get_child_count() - 2:
		adjacent.append(parent.get_child(my_index + 2))
	
	# Check far right plot (+4)
	if my_index < parent.get_child_count() - 4:
		adjacent.append(parent.get_child(my_index + 4))
		
	return adjacent


func try_upgraded_click(plot) -> void:
	print ("Adjacent Plot " + str(plot.get_index()) + " clicked via Upgrade")
	match plot.current_state:
		PlotState.UNTILLED:
			if VariableStorage.current_tool == VariableStorage.TOOL_PLOW:
				plot.current_state = PlotState.TILLED
				VariableStorage.plots_clicked += 1
				VariableStorage.plow_used += 1
			else:
				print("Need Plow selected!")
				return
		PlotState.TILLED:
			if VariableStorage.seeds > 0:
				VariableStorage.seeds -= 1
				plot.current_state = PlotState.PLANTED
				VariableStorage.plots_clicked += 1
			else:
				print("Not enough seeds!")
				return
		PlotState.PLANTED:
			if VariableStorage.current_tool == VariableStorage.TOOL_WATERING_CAN:
				if VariableStorage.water > 0:
					VariableStorage.water -= 1
					plot.current_state = PlotState.GROWING1
					VariableStorage.plots_clicked += 1
				else:
					print("Not enough water!")
					return
			else:
				print("Need Watering Can tool selected!")
				return
		PlotState.GROWING1:
			if VariableStorage.current_tool == VariableStorage.TOOL_WATERING_CAN:
				if VariableStorage.water > 0:
					VariableStorage.water -= 1
					plot.current_state = PlotState.GROWING2
					VariableStorage.plots_clicked += 1
				else:
					print("Not enough water!")
					return
			else:
				print("Need Watering Can tool selected!")
				return
		PlotState.GROWING2:
			if VariableStorage.current_tool == VariableStorage.TOOL_WATERING_CAN:
				if VariableStorage.water > 0:
					VariableStorage.water -= 1
					plot.current_state = PlotState.GROWING3
					VariableStorage.plots_clicked += 1
				else:
					print("Not enough water!")
					return
			else:
				print("Need Watering Can tool selected!")
				return
		PlotState.GROWING3:
			if VariableStorage.current_tool == VariableStorage.TOOL_WATERING_CAN:
				if VariableStorage.water > 0:
					VariableStorage.water -= 1
					plot.current_state = PlotState.GROWN
					VariableStorage.plots_clicked += 1
				else:
					print("Not enough water!")
					return
			else:
				print("Need Watering Can tool selected!")
				return
		PlotState.GROWN:
			if VariableStorage.current_tool == VariableStorage.TOOL_SCYTHE:
				VariableStorage.crops += 1
				plot.current_state = PlotState.UNTILLED
				VariableStorage.plots_clicked += 1
			else:
				print("Need scythe tool selected!")
				return
	plot.button.text = STATE_CHARS[plot.current_state]
	game_update.emit()
	check_unlocks.emit()

# ------------------- Helper Functions ------------------- #

func _game_paused_check() -> bool:
	if VariableStorage.is_game_paused:
		print("Game is paused")
		NotificationManager.show_notification("Paused", "The game is paused.")
		return true
	return false