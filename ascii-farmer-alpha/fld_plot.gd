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
	var original_state = current_state
	match current_state:
		PlotState.UNTILLED:
			if VariableStorage.current_tool == VariableStorage.TOOL_PLOW:
				current_state = PlotState.TILLED
				VariableStorage.plots_clicked += 1
			else:
				print("Need Plow selected!")
				return
		PlotState.TILLED:
			if VariableStorage.seeds > 0:
				VariableStorage.seeds -= 1
				current_state = PlotState.PLANTED
				VariableStorage.plots_clicked += 1
			else:
				print("Not enough seeds!")
				return
		PlotState.PLANTED:
			if VariableStorage.current_tool == VariableStorage.TOOL_WATERING_CAN:
				if VariableStorage.water > 0:
					VariableStorage.water -= 1
					current_state = PlotState.GROWING1
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
					current_state = PlotState.GROWING2
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
					current_state = PlotState.GROWING3
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
					current_state = PlotState.GROWN
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
				current_state = PlotState.UNTILLED
				VariableStorage.plots_clicked += 1
			else:
				print("Need scythe tool selected!")
				return
	if VariableStorage.mkOne_toggle_ON:
		var adjacent_plots = get_adjacent_plots()
		for plot in adjacent_plots:
			if plot.current_state == original_state:
				try_update_plot_state(plot)

	button.text = STATE_CHARS[current_state]
	game_update.emit()
	check_unlocks.emit()


# Adjacent Plot Check
func get_adjacent_plots() -> Array:
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

func try_update_plot_state(plot) -> void:
	match current_state:
		PlotState.UNTILLED:
			if VariableStorage.current_tool == VariableStorage.TOOL_PLOW:
				plot.current_state = PlotState.TILLED
				VariableStorage.plots_clicked += 1
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