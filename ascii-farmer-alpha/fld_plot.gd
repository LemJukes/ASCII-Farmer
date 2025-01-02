extends Control

# Signals
signal game_update

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


# Primary Plot Sequence
func _on_button_pressed():
	VariableStorage.plots_clicked += 1
	match current_state:
		PlotState.UNTILLED:
			if VariableStorage.current_tool == VariableStorage.TOOL_PLOW:
				game_update.emit()
				current_state = PlotState.TILLED
			else:
				print("Need Plow selected!")
				return
		PlotState.TILLED:
			if VariableStorage.seeds > 0:
				VariableStorage.seeds -= 1
				game_update.emit()
				current_state = PlotState.PLANTED
			else:
				print("Not enough seeds!")
				return
		PlotState.PLANTED:
			if VariableStorage.current_tool == VariableStorage.TOOL_WATERING_CAN:
				if VariableStorage.water > 0:
					VariableStorage.water -= 1
					game_update.emit()
					current_state = PlotState.GROWING1
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
					game_update.emit()
					current_state = PlotState.GROWING2
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
					game_update.emit()
					current_state = PlotState.GROWING3
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
					game_update.emit()
					current_state = PlotState.GROWN
				else:
					print("Not enough water!")
					return
			else:
				print("Need Watering Can tool selected!")
				return
		PlotState.GROWN:
			if VariableStorage.current_tool == VariableStorage.TOOL_SCYTHE:
				VariableStorage.crops += 1
				game_update.emit()
				current_state = PlotState.UNTILLED
			else:
				print("Need scythe tool selected!")
				return
	button.text = STATE_CHARS[current_state]
