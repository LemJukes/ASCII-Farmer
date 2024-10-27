extends Control

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

@onready var button = $Button

func _ready():
	button.pressed.connect(_on_button_pressed)
	button.text = STATE_CHARS[current_state]
	
func _on_button_pressed():
	match current_state:
		PlotState.UNTILLED:
			current_state = PlotState.TILLED
		PlotState.TILLED:
			current_state = PlotState.PLANTED
		PlotState.PLANTED:
			current_state = PlotState.GROWING1
		PlotState.GROWING1:
			current_state = PlotState.GROWING2
		PlotState.GROWING2:
			current_state = PlotState.GROWING3
		PlotState.GROWING3:
			current_state = PlotState.GROWN
		PlotState.GROWN:
			current_state = PlotState.UNTILLED
	button.text = STATE_CHARS[current_state]
