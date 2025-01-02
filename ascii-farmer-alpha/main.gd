extends Control

#  ----------------------------------------  DEFAULT GODOT FUCNTIONS  ---------------------------------------- #

# Runs when the application is opened
func _ready() -> void:
	_connect_to_save_manager_signals()
	_initialize_game_labels()
	load_game()

# ----------------------------------------  LABEL UI ELEMENT DECLARATIONS  ----------------------------------------  #

# Inventory Labels
@onready var coins_label: Label = %CoinsValueLabel
@onready var seeds_label: Label = %SeedsValueLabel
@onready var crops_label: Label = %CropsValueLabel
@onready var water_label: Label = %WaterValueLabel
@onready var water_cap_label: Label = %WaterCapValueLabel

# Tool Labels
@onready var current_tool_label: Label = %CurrentToolValueLabel

# Store Labels
# Supplies Labels
@onready var seed_price_label: Label = %SeedPriceLabel
@onready var water_price_label: Label = %WaterPriceLabel
@onready var crop_price_label: Label = %CropPriceLabel

# Plot Labels
@onready var plot_price_label: Label = %PlotPriceLabel

# Upgrade Labels
@onready var click_mk_label: Label = %ClickUpgradeMkLabel
@onready var click_price_label: Label = %ClickUpgradePriceLabel

@onready var bulk_seed_mk_label: Label = %BulkSeedUpgradeMkLabel
@onready var bulk_seed_price_label: Label = %BulkSeedUpgradePriceLabel

@onready var bulk_water_mk_label: Label = %BulkWaterUpgradeMkLabel
@onready var bulk_water_price_label: Label = %BulkWaterUpgradePriceLabel

@onready var bulk_crop_mk_label: Label = %BulkCropUpgradeMkLabel
@onready var bulk_crop_price_label: Label = %BulkCropUpgradePriceLabel

# Field Labels
@onready var field_grid: GridContainer = %FieldGridContainer


# ----------------------------------------  Label UI Element Functions  ----------------------------------------  #

func _update_game_labels() -> void:
	_setup_input_actions()
	_update_inventory_labels()
	_update_tool_labels()
	_update_store_labels()
	save_game()

func _update_inventory_labels() -> void:
	coins_label.text = str(VariableStorage.coins)
	seeds_label.text = str(VariableStorage.seeds)
	crops_label.text = str(VariableStorage.crops)
	water_label.text = str(VariableStorage.water)
	water_cap_label.text = str(VariableStorage.water_cap)

func _update_tool_labels() -> void:
	current_tool_label.text = VariableStorage.current_tool

func _update_store_labels() -> void:
	seed_price_label.text = str(VariableStorage.seed_price)
	water_price_label.text = str(VariableStorage.water_price)
	crop_price_label.text = str(VariableStorage.crop_price)
	plot_price_label.text = str(VariableStorage.plot_price)

# ----------------------------------------  Button UI Element Declarations  ----------------------------------------  #

# System Buttons
@onready var start_button: Button = %StartButton
@onready var quit_button: Button = %QuitButton
@onready var reset_button: Button = %ResetButton

# Tool Buttons
@onready var plow_button: Button = %PlowButton
@onready var watering_can_button: Button = %WateringCanButton
@onready var scythe_button: Button = %ScytheButton

# Store Buttons
# Supplies Buttons
# Seed Buttons
@onready var buy_one_seed_button: Button = %BuyOneSeedButton
@onready var buy_three_seed_button: Button = %BuyThreeSeedButton
@onready var buy_nine_seed_button: Button = %BuyNineSeedButton
# Water Buttons
@onready var buy_ten_water_button: Button = %BuyTenWaterButton
@onready var buy_thirty_water_button: Button = %BuyThirtyWaterButton
@onready var buy_ninety_water_button: Button = %BuyNinetyWaterButton
# Crop Buttons
@onready var sell_one_crop_button: Button = %SellOneCropButton
@onready var sell_three_crop_button: Button = %SellThreeCropButton
@onready var sell_nine_crop_button: Button = %SellNineCropButton
# Buy Plot Button
@onready var buy_plot_button: Button = %BuyPlotButton

var input_actions = {
    "tool_plow": "_on_plow_button_pressed",
    "tool_water": "_on_watering_can_button_pressed", 
    "tool_scythe": "_on_scythe_button_pressed",
    "buy_seed": "_on_buy_one_seed_button_pressed",
    "sell_crop": "_on_sell_one_crop_button_pressed",
    "buy_plot": "_on_buy_plot_button_pressed"
}

# ----------------------------------------  Button UI Element Functions  ----------------------------------------  #

# Handle input events
func _unhandled_input(event: InputEvent) -> void:
	for action_name in input_actions:
		if event.is_action_pressed(action_name):
			# Call the corresponding function
			call(input_actions[action_name])
			get_viewport().set_input_as_handled()
			return


func _setup_input_actions() -> void:
    # Tool shortcuts
	_add_input_action("tool_plow", KEY_A)
	_add_input_action("tool_water", KEY_S) 
	_add_input_action("tool_scythe", KEY_D)
    
    # Store shortcuts
	_add_input_action("buy_seed", KEY_Q)
	_add_input_action("sell_crop", KEY_W)
	_add_input_action("buy_plot", KEY_E)

# ----------------------------------------  Game Initialization  ----------------------------------------  #


func _initialize_game_labels() -> void:
	# Initialize the Inventory Labels
	coins_label.text = "0"
	seeds_label.text = "0"
	crops_label.text = "0"
	water_label.text = "0"
	water_cap_label.text = "0"

	# Initialize the Tool Labels
	current_tool_label.text = VariableStorage.current_tool

	# Initialize the Store Prices
	# Supplies Prices
	seed_price_label.text = "0"
	water_price_label.text = "0"
	crop_price_label.text = "0"

	# Plot Price
	plot_price_label.text = "0"

	# Upgrade Prices
	click_mk_label.text = "0"
	click_price_label.text = "0"
	
	bulk_seed_mk_label.text = "0"
	bulk_seed_price_label.text = "0"

	bulk_water_mk_label.text = "0"
	bulk_water_price_label.text = "0"

	bulk_crop_mk_label.text = "0"
	bulk_crop_price_label.text = "0"

# ----------------------------------------  Save Manager  ---------------------------------------- #

# Step 1: Basic save with plot states
func save_game() -> void:
	var plot_states = []
	for plot in field_grid.get_children():
		plot_states.append(plot.current_state)
	
	var save_dict = {

		# Inventory Data
		"coins": VariableStorage.coins,
		"seeds": VariableStorage.seeds,
		"crops": VariableStorage.crops,
		"water": VariableStorage.water,
		"water_cap": VariableStorage.water_cap,

		# Tool Data
		"current_tool": VariableStorage.current_tool,
		
		# Store Price Data
		"seed_price": VariableStorage.seed_price,
		"water_price": VariableStorage.water_price,
		"crop_price": VariableStorage.crop_price,
		"plot_price": VariableStorage.plot_price,

		# Field Data
		"plot_count": field_grid.get_child_count(),
		"plot_states": plot_states,

		# Inventory Counters
		"coins_earned": VariableStorage.coins_earned,
		"seeds_collected": VariableStorage.seeds_collected,
		"crops_harvested": VariableStorage.crops_harvested,
		"water_used": VariableStorage.water_used,

		# Tool Counters
		"plow_used": VariableStorage.plow_used,
		"watering_can_used": VariableStorage.watering_can_used,
		"scythe_used": VariableStorage.scythe_used,

		# Store Transaction Counters
		"seeds_purchased": VariableStorage.seeds_purchased,
		"water_purchased": VariableStorage.water_purchased,
		"crops_sold": VariableStorage.crops_sold,

		# Field Counters
		"plots_purchased": VariableStorage.plots_purchased,
		"plots_tilled": VariableStorage.plots_tilled,
		"plots_planted": VariableStorage.plots_planted,
		"plots_watered": VariableStorage.plots_watered,
		"plots_harvested": VariableStorage.plots_harvested,

	}
	
	print("Saving:", save_dict)
	SaveManager.save_game_data(save_dict)

# Step 2: Basic load with plot states
func load_game() -> void:
	var save_data = SaveManager.load_game_data()
	print("Loading save data:", save_data)
	
	# Early return if no valid save data
	if !save_data.has("plot_count") || !save_data.has("plot_states"):
		print("No valid save data found")
		return
		
	var plot_count = save_data["plot_count"] as int
	var states = save_data["plot_states"] as Array
	
	print("Plot count:", plot_count)
	print("Plot states:", states)
	
	# Validate states array
	if states.size() < plot_count:
		print("Invalid state data")
		return
		
	# Create first plot if needed
	if plot_count > 0:
		field_grid._add_first_plot()
		var first = field_grid.get_child(0)
		if first && states.size() > 0:
			first.current_state = int(states[0])
			first.button.text = first.STATE_CHARS.get(first.current_state, "~")
	
		# Create remaining plots
		for i in range(1, plot_count):
			if i >= states.size():
				break
			field_grid.add_plot()
			var plot = field_grid.get_child(i)
			if plot:
				plot.current_state = int(states[i])
				plot.button.text = plot.STATE_CHARS.get(plot.current_state, "~")
	
	# Load the rest of the game data
	if !save_data.is_empty():
		print("Loading Save Data:", save_data)
		
		# Inventory Data
		VariableStorage.coins = save_data["coins"]
		VariableStorage.seeds = save_data["seeds"]
		VariableStorage.crops = save_data["crops"]
		VariableStorage.water = save_data["water"]
		VariableStorage.water_cap = save_data["water_cap"]

		# Tool Data
		VariableStorage.current_tool = save_data["current_tool"]

		# Store Price Data
		VariableStorage.seed_price = save_data["seed_price"]
		VariableStorage.water_price = save_data["water_price"]
		VariableStorage.crop_price = save_data["crop_price"]
		VariableStorage.plot_price = save_data["plot_price"]

		# Field Data
		VariableStorage.plot_count = save_data["plot_count"]

		# Inventory Counters
		VariableStorage.coins_earned = save_data["coins_earned"]
		VariableStorage.seeds_collected = save_data["seeds_collected"] 
		VariableStorage.crops_harvested = save_data["crops_harvested"]
		VariableStorage.water_used = save_data["water_used"]
		
		# Tool Counters
		VariableStorage.plow_used = save_data["plow_used"]
		VariableStorage.watering_can_used = save_data["watering_can_used"]
		VariableStorage.scythe_used = save_data["scythe_used"]

		# Store Transaction Counters
		VariableStorage.seeds_purchased = save_data["seeds_purchased"]
		VariableStorage.water_purchased = save_data["water_purchased"]
		VariableStorage.crops_sold = save_data["crops_sold"]

		# Field Counters
		VariableStorage.plots_purchased = save_data["plots_purchased"]
		VariableStorage.plots_tilled = save_data["plots_tilled"]
		VariableStorage.plots_planted = save_data["plots_planted"]
		VariableStorage.plots_watered = save_data["plots_watered"]
		VariableStorage.plots_harvested = save_data["plots_harvested"]

		_set_sys_buttons_gameON()
		_unlock_starting_buttons()
		_check_all_unlock_counters()
		_update_game_labels()

# Signal connector for SaveManager
func _connect_to_save_manager_signals() -> void:
	SaveManager.save_completed.connect(_on_save_completed)
	SaveManager.load_completed.connect(_on_load_completed)
	SaveManager.save_error.connect(_on_save_error)
	SaveManager.load_error.connect(_on_load_error)

# Signal handlers for SaveManager
func _on_save_completed() -> void:
	print("Game saved successfully")

func _on_load_completed() -> void:
	print("Game loaded successfully")

func _on_save_error(save_error_message: String) -> void:
	print("Save error: ",save_error_message)

func _on_load_error(load_error_message: String) -> void:
	print("Load error: ",load_error_message)

# ----------------------------------------  Helper & Other Background Functions  ----------------------------------------  #

func _unlock_starting_buttons() -> void:
	# Handle system button state changes
	start_button.disabled = true
	reset_button.disabled = false

	# handle tool button state changes
	plow_button.disabled = false
	watering_can_button.disabled = false
	scythe_button.disabled = false

	# handle store button state changes
	buy_one_seed_button.disabled = false
	buy_ten_water_button.disabled = false
	sell_one_crop_button.disabled = false
	buy_plot_button.disabled = false

# Helper to add input actions
func _add_input_action(action_name: String, keycode: int) -> void:
	if !InputMap.has_action(action_name):
		InputMap.add_action(action_name)
		var event = InputEventKey.new()
		event.keycode = keycode
		InputMap.action_add_event(action_name, event)

# ----------------------------------------  System Buttons  ----------------------------------------  #.

func _on_start_button_pressed() -> void:
	print("Start button pressed")
	
	_unlock_starting_buttons()
	_update_game_labels()
	field_grid._add_first_plot()

	# Save game data
	save_game()

func _on_reset_button_pressed() -> void:
	print("Reset button pressed")

	SaveManager.delete_save()

	VariableStorage.reset_game_data()

	_initialize_game_labels()

	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	# adding this print statement is what makes the if statment below work properly, i do not understand why but it works so im leaving it for now.
	print("Quit button pressed")
	# If a save file exists, save the game data
	if FileAccess.file_exists(SaveManager.SAVE_FILE_PATH):
		save_game()
		get_tree().call_deferred("quit")
	else:
		print("No save file found. Quitting without saving.")
		get_tree().call_deferred("quit")

func _set_sys_buttons_gameON() -> void:
	start_button.disabled = true
	reset_button.disabled = false

func _set_sys_buttons_gameOFF() -> void:
	start_button.disabled = false
	reset_button.disabled = true

# ----------------------------------------  Tool Buttons  ----------------------------------------  #

func _on_plow_button_pressed() -> void:
	print("Plow button pressed")
	VariableStorage.current_tool = VariableStorage.TOOL_PLOW	
	_update_game_labels()

func _on_watering_can_button_pressed() -> void:
	print("Watering Can button pressed")
	VariableStorage.current_tool = VariableStorage.TOOL_WATERING_CAN
	_update_game_labels()

func _on_scythe_button_pressed() -> void:
	print("Scythe button pressed")
	VariableStorage.current_tool = VariableStorage.TOOL_SCYTHE
	_update_game_labels()

# ----------------------------------------  Store Buttons  ----------------------------------------  #

# Supplies Buttons
# Seed Buttons

func _on_buy_one_seed_button_pressed() -> void:
	print("Buy One Seed button pressed")
	if VariableStorage.coins >= VariableStorage.seed_price:
		VariableStorage.coins -= VariableStorage.seed_price
		VariableStorage.seeds += 1
		VariableStorage.seeds_purchased += 1
		_check_bulk_seed_unlock_counter()
		_update_game_labels()
		
	else:
		print("Not enough coins to purchase seeds")

func _on_buy_three_seed_button_pressed() -> void:
	print("Buy Three Seed button pressed")
	if VariableStorage.coins >= VariableStorage.seed_price:
		VariableStorage.coins -= VariableStorage.seed_price
		VariableStorage.seeds += 3
		VariableStorage.seeds_purchased += 3
		_check_bulk_seed_unlock_counter()
		_update_game_labels()
		
	else:
		print("Not enough coins to purchase seeds")

func _on_buy_nine_seed_button_pressed() -> void:
	if VariableStorage.coins >= VariableStorage.seed_price:
		VariableStorage.coins -= VariableStorage.seed_price
		VariableStorage.seeds += 9
		VariableStorage.seeds_purchased += 9
		_check_bulk_seed_unlock_counter()
		_update_game_labels()
		
	else:
		print("Not enough coins to purchase seeds")


# Water Buttons

func _on_buy_ten_water_button_pressed() -> void:
	print("Buy Ten Water button pressed")
	if VariableStorage.water >= VariableStorage.water_cap:
		print("Water storage is at capacity!")
		return
		
	if VariableStorage.coins >= VariableStorage.water_price:
		var space_remaining = VariableStorage.water_cap - VariableStorage.water
		var water_to_add = min(10, space_remaining)
		
		if water_to_add == 0:
			print("Cannot add more water - at capacity!")
			return
			
		VariableStorage.coins -= VariableStorage.water_price
		VariableStorage.water += water_to_add
		VariableStorage.water_purchased += water_to_add
		_update_game_labels()
		
		if water_to_add < 10:
			print("Only added " + str(water_to_add) + " water due to capacity limits")
	else:
		print("Not enough coins to purchase water")

func _on_buy_thirty_water_button_pressed() -> void:
	pass # Replace with function body.

func _on_buy_ninety_water_button_pressed() -> void:
	pass # Replace with function body.


# Crop Buttons

func _on_sell_one_crop_button_pressed() -> void:
	print("Sell One Crop button pressed")
	if VariableStorage.crops > 0:
		VariableStorage.crops -= 1
		VariableStorage.coins += VariableStorage.crop_price
		VariableStorage.crops_sold += 1
		_check_bulk_crop_unlock_counter()
		_update_game_labels()
	else:
		print("Not enough crops to sell")

func _on_sell_three_crop_button_pressed() -> void:
	print("Sell Three Crop button pressed")
	if VariableStorage.crops >= 3:
		VariableStorage.crops -= 3
		VariableStorage.coins += VariableStorage.crop_price * 3
		VariableStorage.crops_sold += 3
		_check_bulk_crop_unlock_counter()
		_update_game_labels()
	else:
		print("Not enough crops to sell")

func _on_sell_nine_crop_button_pressed() -> void:
	print("Sell Nine Crop button pressed")
	if VariableStorage.crops >= 9:
		VariableStorage.crops -= 9
		VariableStorage.coins += VariableStorage.crop_price * 9
		VariableStorage.crops_sold += 9
		_check_bulk_crop_unlock_counter()
		_update_game_labels()
	else:
		print("Not enough crops to sell")

# Buy Plot Button

func _on_buy_plot_button_pressed() -> void:
	print("Buy Plot button pressed")
	if VariableStorage.coins >= VariableStorage.plot_price:
		var field_handler = field_grid # The field_grid already has fld_handler.gd attached
		if field_handler.check_plot_count():
			VariableStorage.coins -= VariableStorage.plot_price
			VariableStorage.plots_purchased += 1
			field_handler.add_plot()
			_update_game_labels()
			
			# Increase price for next plot
			VariableStorage.plot_price *= 2
			plot_price_label.text = str(VariableStorage.plot_price)
	else:
		print("Not enough coins to purchase plot")

# ----------------------------------------  Upgrade Unlock Checks ----------------------------------------  #

func _check_all_unlock_counters() -> void:
	_check_bulk_seed_unlock_counter()
	_check_bulk_water_unlock_counter()
	_check_bulk_crop_unlock_counter()
	_check_plots_clicked_counter()

func _check_bulk_seed_unlock_counter() -> void:
	if VariableStorage.seeds_purchased >= 100:
		buy_three_seed_button.disabled = false
	elif VariableStorage.seeds_purchased >= 300:
		buy_nine_seed_button.disabled = false

func _check_bulk_water_unlock_counter() -> void:
	if VariableStorage.water_purchased >= 100:
		buy_thirty_water_button.disabled = false
	elif VariableStorage.water_purchased >= 1000:
		buy_ninety_water_button.disabled = false

func _check_bulk_crop_unlock_counter() -> void:
	if VariableStorage.crops_sold >= 100:
		sell_three_crop_button.disabled = false
	elif VariableStorage.crops_sold >= 300:
		sell_nine_crop_button.disabled = false

func _check_plots_clicked_counter() -> void:
	if VariableStorage.plots_clicked >= 100:
		pass # Replace with function body.