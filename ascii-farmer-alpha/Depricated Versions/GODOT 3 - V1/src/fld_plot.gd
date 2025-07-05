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
	GROWN,
	WITHERED
}

# Mapping States to their respective Characters
const STATE_CHARS = {
	PlotState.UNTILLED: "~",
	PlotState.TILLED: "=",
	PlotState.PLANTED: "¤",
	PlotState.GROWING1: "\\",
	PlotState.GROWING2: "|",
	PlotState.GROWING3: "/",
	PlotState.GROWN: "¥",
	PlotState.WITHERED: "ᕦ"
}

# Current state of the plot
var current_state = PlotState.UNTILLED
var wither_timer: Timer
var harvest_counter = 0
var fallow_timer: Timer

@onready var button = $PlotButton

func _ready():
	button.pressed.connect(_on_button_pressed)
	button.text = STATE_CHARS[current_state]
	
	var main = get_node("/root/Control")
	
	game_update.connect(main._update_game_labels)
	check_unlocks.connect(main._check_all_unlock_counters)

	wither_timer = Timer.new()
	wither_timer.wait_time = 10.0
	wither_timer.one_shot = true
	wither_timer.timeout.connect(_on_wither_timer_timeout)
	add_child(wither_timer)

	fallow_timer = Timer.new()
	fallow_timer.wait_time = 3.0
	fallow_timer.one_shot = true
	fallow_timer.timeout.connect(_on_fallow_timer_timeout)
	add_child(fallow_timer)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):  # Space bar
		if button.is_hovered():
			button.emit_signal("pressed")
			get_viewport().set_input_as_handled()

func _on_wither_timer_timeout():
	if current_state == PlotState.GROWN:
		current_state = PlotState.WITHERED
		button.text = STATE_CHARS[current_state]
		game_update.emit()

func _on_fallow_timer_timeout():
	button.disabled = false
	button.modulate = Color(1, 1, 1, 1)

# Primary Plot Sequence
func _on_button_pressed():
	if _game_paused_check(): return
	print ("Plot " + str(get_index()) + " clicked")
	var original_state = current_state

	if VariableStorage.tc_toggle_ON && VariableStorage.tc_charge > 0:
		match current_state:
			PlotState.UNTILLED:
				if VariableStorage.current_tool != VariableStorage.TOOL_PLOW:
					VariableStorage.current_tool = VariableStorage.TOOL_PLOW
					VariableStorage.tc_charge -= 1
			PlotState.PLANTED, PlotState.GROWING1, PlotState.GROWING2, PlotState.GROWING3:
				if VariableStorage.current_tool != VariableStorage.TOOL_WATERING_CAN:
					VariableStorage.current_tool = VariableStorage.TOOL_WATERING_CAN
					VariableStorage.tc_charge -= 1
			PlotState.GROWN, PlotState.WITHERED:
				if VariableStorage.current_tool != VariableStorage.TOOL_SCYTHE:
					VariableStorage.current_tool = VariableStorage.TOOL_SCYTHE
					VariableStorage.tc_charge -= 1

	match current_state:
		PlotState.UNTILLED:
			if VariableStorage.current_tool == VariableStorage.TOOL_PLOW:
				current_state = PlotState.TILLED
				VariableStorage.plots_clicked += 1
				VariableStorage.plow_used += 1
				if randf() <= 0.05:
					VariableStorage.add_coins(randi_range(1, 10))
					print("Found some coins while plowing!")
					NotificationManager.show_notification("Lucky!", "Found a coin while plowing!")
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
					wither_timer.start()
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
				wither_timer.stop()

				harvest_counter += 1
				if harvest_counter >= 3:
					harvest_counter = 0
					button.disabled = true
					button.modulate = Color(1, 1, 1, 0.5)  # Dim the button
					fallow_timer.start()
                
				if randf() <= 0.15:
					VariableStorage.seeds += 1
					print("Seed Drop!")
					NotificationManager.show_notification("Seed Drop!","A seed has dropped!")
			else:
				print("Need scythe tool selected!")
				NotificationManager.show_notification("Wrong Tool","Need scythe tool selected!")
				return
		PlotState.WITHERED:  
			if VariableStorage.current_tool == VariableStorage.TOOL_SCYTHE:
				current_state = PlotState.UNTILLED
				VariableStorage.plots_clicked += 1
				if randf() <= 0.25:  
					VariableStorage.seeds += 1
					print("Seed Drop from withered plant!")
					NotificationManager.show_notification("Seed Drop!","A seed has dropped from the withered plant!")
			elif VariableStorage.current_tool == VariableStorage.TOOL_PLOW:
				current_state = PlotState.TILLED
				VariableStorage.plots_clicked += 1
				VariableStorage.plow_used += 1
			else:
				print("Need scythe or plow tool selected!")
				NotificationManager.show_notification("Wrong Tool","Need scythe or plow tool selected!")
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
				if randf() <= 0.01:  # 1% chance
					VariableStorage.add_coins(1)
					print("Found a coin while plowing!")
					NotificationManager.show_notification("Lucky!", "Found a coin while plowing!")
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
					wither_timer.start()
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
				wither_timer.stop()

				# Handle harvest counter for upgraded clicks
				plot.harvest_counter += 1
				if plot.harvest_counter >= 3:
					plot.harvest_counter = 0
					plot.button.disabled = true
					plot.button.modulate = Color(1, 1, 1, 0.5)
					plot.fallow_timer.start()
			else:
				print("Need scythe tool selected!")
				return
		PlotState.WITHERED:
			if VariableStorage.current_tool == VariableStorage.TOOL_SCYTHE:
				plot.current_state = PlotState.UNTILLED
				VariableStorage.plots_clicked += 1
				_reset_harvest_counter()
			elif VariableStorage.current_tool == VariableStorage.TOOL_PLOW:
				plot.current_state = PlotState.TILLED
				VariableStorage.plots_clicked += 1
				_reset_harvest_counter()
			else:
				print("Need scythe or plow tool selected!")
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

func _reset_harvest_counter():
	harvest_counter = 0