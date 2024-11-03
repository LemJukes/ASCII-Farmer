extends Control

# Signals
signal inv_update

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
	# Seeds Used Connections
	var primary = get_node("/root/AsciiFarmer/Primary")
	inv_update.connect(primary.update_inventory)

# Primary Plot Sequence
func _on_button_pressed():
	_inc_plots_clicked()
	match current_state:
		PlotState.UNTILLED:
			if vs.current_tool == vs.plow_tool:
				current_state = PlotState.TILLED
			else:
				print("Need Plow selected!")
				return
		PlotState.TILLED:
			if vs.seeds > 0:
				vs.seeds -= 1
				inv_update.emit()
				current_state = PlotState.PLANTED
			else:
				print("Not enough seeds!")
				return
		PlotState.PLANTED:
			if vs.current_tool == vs.water_tool:
				if vs.water > 0:
					vs.water -= 1
					inv_update.emit()
					current_state = PlotState.GROWING1
				else:
					print("Not enough water!")
					return
			else:
				print("Need Watering Can tool selected!")
				return
		PlotState.GROWING1:
			if vs.current_tool == vs.water_tool:
				if vs.water > 0:
					vs.water -= 1
					inv_update.emit()
					current_state = PlotState.GROWING2
				else:
					print("Not enough water!")
					return
			else:
				print("Need Watering Can tool selected!")
				return
		PlotState.GROWING2:
			if vs.current_tool == vs.water_tool:
				if vs.water > 0:
					vs.water -= 1
					inv_update.emit()
					current_state = PlotState.GROWING3
				else:
					print("Not enough water!")
					return
			else:
				print("Need Watering Can tool selected!")
				return
		PlotState.GROWING3:
			current_state = PlotState.GROWN
		PlotState.GROWN:
			if vs.current_tool == vs.scythe_tool:
				vs.crops += 1
				inv_update.emit()
				current_state = PlotState.UNTILLED
			else:
				print("Need scythe tool selected!")
				return
	button.text = STATE_CHARS[current_state]
	
# Milestone Functions
func _inc_plots_clicked():
	vs.plots_clicked += 1
	print(str(vs.plots_clicked) + " Plots Clicked")
	pass
