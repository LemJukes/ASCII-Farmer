extends Control

#  ----------------------------------------  DEFAULT GODOT FUCNTIONS  ---------------------------------------- #

# Runs when the application is opened
func _ready() -> void:
	_connect_to_save_manager_signals()
	_connect_button_signals()
	_setup_input_actions()
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
@onready var UpgradesStoreContainer = %UpgradesVBoxContainer

@onready var BuyWaterUpgradesContainer = %BuyWaterCapUpgradesVBoxContainer
@onready var water_cap_mk_label: Label = %WaterCapUpgradeMkLabel
@onready var water_cap_price_label: Label = %WaterCapUpgradePriceLabel

@onready var BuyClickUpgradeContainer = %BuyClickUpgradesVBoxContainer
@onready var click_mk_label: Label = %ClickUpgradeMkLabel
@onready var click_price_label: Label = %ClickUpgradePriceLabel

# Field Labels
@onready var field_grid: GridContainer = %FieldGridContainer


# ----------------------------------------  Label UI Element Functions  ----------------------------------------  #

func _update_game_labels() -> void:
	_check_all_unlock_counters()
	_update_inventory_labels()
	_update_tool_labels()
	_update_store_labels()
	_update_upgrade_labels()
	_update_upgrade_toggles()
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

func _update_upgrade_labels() -> void:
	water_cap_mk_label.text = str(VariableStorage.water_cap_upgrade_mk)
	water_cap_price_label.text = str(VariableStorage.water_cap_upgrade_price)

	click_mk_label.text = str(VariableStorage.click_upgrade_mk + 1)
	click_price_label.text = str(VariableStorage.click_upgrade_price)

func _update_upgrade_toggles() -> void:
	mkOne_toggle.button_pressed = VariableStorage.mkOne_toggle_ON
	mkTwo_toggle.button_pressed = VariableStorage.mkTwo_toggle_ON
	mkThree_toggle.button_pressed = VariableStorage.mkThree_toggle_ON

# ----------------------------------------  Button UI Element Declarations  ----------------------------------------  #

# System Buttons
@onready var start_button: Button = %StartButton
@onready var quit_button: Button = %QuitButton
@onready var reset_button: Button = %ResetButton

# Tool Buttons
@onready var plow_button: Button = %PlowButton
@onready var watering_can_button: Button = %WateringCanButton
@onready var scythe_button: Button = %ScytheButton

# Upgrade Toggles
@onready var mkOne_toggle: CheckButton = %MkOneControlToggle
@onready var mkTwo_toggle: CheckButton = %MkTwoControlToggle
@onready var mkThree_toggle: CheckButton = %MkThreeControlToggle

# Store Buttons
@onready var buy_one_seed_button: Button = %BuyOneSeedButton
@onready var buy_three_seed_button: Button = %BuyThreeSeedButton
@onready var buy_nine_seed_button: Button = %BuyNineSeedButton

@onready var buy_ten_water_button: Button = %BuyTenWaterButton
@onready var buy_thirty_water_button: Button = %BuyThirtyWaterButton
@onready var buy_ninety_water_button: Button = %BuyNinetyWaterButton

@onready var sell_one_crop_button: Button = %SellOneCropButton
@onready var sell_three_crop_button: Button = %SellThreeCropButton
@onready var sell_nine_crop_button: Button = %SellNineCropButton

@onready var buy_plot_button: Button = %BuyPlotButton

@onready var buy_click_upgrade_button: Button = %BuyClickUpgradeButton
@onready var buy_water_cap_upgrade_button: Button = %BuyWaterCapUpgradeButton

# Keboard Binding Actions Dictionary

var input_actions = {
	"tool_plow": "_on_plow_button_pressed",
	"tool_water": "_on_watering_can_button_pressed", 
	"tool_scythe": "_on_scythe_button_pressed",
	"plot_1": "_on_plot_1_pressed",
    "plot_2": "_on_plot_2_pressed",
    "plot_3": "_on_plot_3_pressed",
    "plot_4": "_on_plot_4_pressed",
    "plot_5": "_on_plot_5_pressed",
    "plot_6": "_on_plot_6_pressed",
    "plot_7": "_on_plot_7_pressed",
    "plot_8": "_on_plot_8_pressed",
    "plot_9": "_on_plot_9_pressed"
	
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

	# Plot shortcuts
	_add_input_action("plot_7", KEY_KP_7)
	_add_input_action("plot_8", KEY_KP_8)
	_add_input_action("plot_9", KEY_KP_9)
	_add_input_action("plot_4", KEY_KP_4)
	_add_input_action("plot_5", KEY_KP_5)
	_add_input_action("plot_6", KEY_KP_6)
	_add_input_action("plot_1", KEY_KP_1)
	_add_input_action("plot_2", KEY_KP_2)
	_add_input_action("plot_3", KEY_KP_3)
	
func _click_plot(plot_index: int) -> void:
	if field_grid.get_child_count() > plot_index:
		var plot = field_grid.get_child(plot_index)
		plot.button.emit_signal("pressed")

func _on_plot_1_pressed() -> void:
	_click_plot(6)  # Index 6 corresponds to position 1 on keypad

func _on_plot_2_pressed() -> void:
	_click_plot(7)  # Index 7 corresponds to position 2 on keypad

func _on_plot_3_pressed() -> void:
	_click_plot(8)  # Index 8 corresponds to position 3 on keypad

func _on_plot_4_pressed() -> void:
	_click_plot(3)  # Index 3 corresponds to position 4 on keypad

func _on_plot_5_pressed() -> void:
	_click_plot(4)  # Index 4 corresponds to position 5 on keypad

func _on_plot_6_pressed() -> void:
	_click_plot(5)  # Index 5 corresponds to position 6 on keypad

func _on_plot_7_pressed() -> void:
	_click_plot(0)  # Index 0 corresponds to position 7 on keypad

func _on_plot_8_pressed() -> void:
	_click_plot(1)  # Index 1 corresponds to position 8 on keypad

func _on_plot_9_pressed() -> void:
	_click_plot(2)  # Index 2 corresponds to position 9 on keypad

func _connect_button_signals() -> void:
	_connect_system_button_signals()
	_connect_tool_button_signals()
	_connect_store_button_signals()
	_connect_upgrade_button_signals()

func _connect_system_button_signals() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	reset_button.pressed.connect(_on_reset_button_pressed)

func _connect_tool_button_signals() -> void:
	plow_button.pressed.connect(_on_plow_button_pressed)
	watering_can_button.pressed.connect(_on_watering_can_button_pressed)
	scythe_button.pressed.connect(_on_scythe_button_pressed)

func _connect_store_button_signals() -> void:
	buy_one_seed_button.pressed.connect(_on_buy_one_seed_button_pressed)
	buy_three_seed_button.pressed.connect(_on_buy_three_seed_button_pressed)
	buy_nine_seed_button.pressed.connect(_on_buy_nine_seed_button_pressed)

	buy_ten_water_button.pressed.connect(_on_buy_ten_water_button_pressed)
	buy_thirty_water_button.pressed.connect(_on_buy_thirty_water_button_pressed)
	buy_ninety_water_button.pressed.connect(_on_buy_ninety_water_button_pressed)

	sell_one_crop_button.pressed.connect(_on_sell_one_crop_button_pressed)
	sell_three_crop_button.pressed.connect(_on_sell_three_crop_button_pressed)
	sell_nine_crop_button.pressed.connect(_on_sell_nine_crop_button_pressed)

	buy_plot_button.pressed.connect(_on_buy_plot_button_pressed)

	buy_click_upgrade_button.pressed.connect(_on_buy_click_upgrade_button_pressed)
	buy_water_cap_upgrade_button.pressed.connect(_on_buy_water_cap_upgrade_button_pressed)


func _connect_upgrade_button_signals() -> void:
	mkOne_toggle.toggled.connect(_on_mkOne_toggle_toggled)
	mkTwo_toggle.toggled.connect(_on_mkTwo_toggle_toggled)
	mkThree_toggle.toggled.connect(_on_mkThree_toggle_toggled)

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
		"crops_harvested": VariableStorage.crops_harvested,

		# Tool Counters
		"plow_used": VariableStorage.plow_used,
		"water_used": VariableStorage.water_used,

		# Store Transaction Counters
		"seeds_purchased": VariableStorage.seeds_purchased,
		"water_purchased": VariableStorage.water_purchased,
		"crops_sold": VariableStorage.crops_sold,

		# Field Counters
		"plots_purchased": VariableStorage.plots_purchased,
		"plots_clicked": VariableStorage.plots_clicked,

		"water_cap_upgrade_mk": VariableStorage.water_cap_upgrade_mk,
		"water_cap_mk_unlocked": VariableStorage.water_cap_mk_unlocked,
		"water_cap_mk_purchased": VariableStorage.water_cap_mk_purchased,

		# Upgrade Counters
		"click_upgrade_mk": VariableStorage.click_upgrade_mk,

		"mkOne_purchased": VariableStorage.mkOne_purchased,
		"mkTwo_purchased": VariableStorage.mkTwo_purchased,
		"mkThree_purchased": VariableStorage.mkThree_purchased,

		"mkOne_toggle_ON": VariableStorage.mkOne_toggle_ON,
		"mkTwo_toggle_ON": VariableStorage.mkTwo_toggle_ON,
		"mkThree_toggle_ON": VariableStorage.mkThree_toggle_ON

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
		VariableStorage.crops_harvested = save_data["crops_harvested"]

		# Tool Counters
		VariableStorage.plow_used = save_data["plow_used"]
		VariableStorage.water_used = save_data["water_used"]

		# Store Transaction Counters
		VariableStorage.seeds_purchased = save_data["seeds_purchased"]
		VariableStorage.water_purchased = save_data["water_purchased"]
		VariableStorage.crops_sold = save_data["crops_sold"]

		# Field Counters
		VariableStorage.plots_purchased = save_data["plots_purchased"]
		VariableStorage.plots_clicked = save_data["plots_clicked"]
		
		# Upgrade Counters
		VariableStorage.water_cap_upgrade_mk = save_data["water_cap_upgrade_mk"]
		VariableStorage.water_cap_mk_unlocked = save_data["water_cap_mk_unlocked"]
		VariableStorage.water_cap_mk_purchased = save_data["water_cap_mk_purchased"]
		VariableStorage.click_upgrade_mk = save_data["click_upgrade_mk"]
		VariableStorage.mkOne_purchased = save_data["mkOne_purchased"]
		VariableStorage.mkTwo_purchased = save_data["mkTwo_purchased"]
		VariableStorage.mkThree_purchased = save_data["mkThree_purchased"]
		VariableStorage.mkOne_toggle_ON = save_data["mkOne_toggle_ON"]
		VariableStorage.mkTwo_toggle_ON = save_data["mkTwo_toggle_ON"]
		VariableStorage.mkThree_toggle_ON = save_data["mkThree_toggle_ON"]
		

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
		# Handle mk1 toggle

func _on_load_error(load_error_message: String) -> void:
	print("Load error: ",load_error_message)

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
	_check_all_unlock_counters()
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

# ----------------------------------------  Upgrade Toggles  ----------------------------------------  #

func _on_mkOne_toggle_toggled(_button_presed: bool) -> void:
	VariableStorage.mkOne_toggle_ON = _button_presed
	print("Mk. 1 toggle pressed" + str(VariableStorage.mkOne_toggle_ON))
	_update_game_labels()

func _on_mkTwo_toggle_toggled(_button_pressed: bool) -> void:
	VariableStorage.mkTwo_toggle_ON = _button_pressed
	print("Mk. 2 toggle pressed" + str(VariableStorage.mkTwo_toggle_ON))
	_update_game_labels()

func _on_mkThree_toggle_toggled() -> void:
	VariableStorage.mkThree_toggle_ON = true
	print("Mk. 3 toggle pressed" + str(VariableStorage.mkThree_toggle_ON))
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
		_update_game_labels()
		
	else:
		print("Not enough coins to purchase seeds")

func _on_buy_three_seed_button_pressed() -> void:
	print("Buy Three Seed button pressed")
	if VariableStorage.coins >= VariableStorage.seed_price:
		VariableStorage.coins -= VariableStorage.seed_price
		VariableStorage.seeds += 3
		VariableStorage.seeds_purchased += 3
		_update_game_labels()
		
	else:
		print("Not enough coins to purchase seeds")

func _on_buy_nine_seed_button_pressed() -> void:
	if VariableStorage.coins >= VariableStorage.seed_price:
		VariableStorage.coins -= VariableStorage.seed_price
		VariableStorage.seeds += 9
		VariableStorage.seeds_purchased += 9
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
	print("Buy Thirty Water button pressed")
	if VariableStorage.water >= VariableStorage.water_cap:
		print("Water storage is at capacity!")
		return

	if VariableStorage.coins >= VariableStorage.water_price:
		var space_remaining = VariableStorage.water_cap - VariableStorage.water
		var water_to_add = min(30, space_remaining)
		
		if water_to_add == 0:
			print("Cannot add more water - at capacity!")
			return
			
		VariableStorage.coins -= VariableStorage.water_price
		VariableStorage.water += water_to_add
		VariableStorage.water_purchased += water_to_add
		_update_game_labels()
		
		if water_to_add < 30:
			print("Only added " + str(water_to_add) + " water due to capacity limits")
	else:
		print("Not enough coins to purchase water")

func _on_buy_ninety_water_button_pressed() -> void:
	print("Buy Ninety Water button pressed")
	if VariableStorage.water >= VariableStorage.water_cap:
		print("Water storage is at capacity!")
		return

	if VariableStorage.coins >= VariableStorage.water_price:
		var space_remaining = VariableStorage.water_cap - VariableStorage.water
		var water_to_add = min(90, space_remaining)
		
		if water_to_add == 0:
			print("Cannot add more water - at capacity!")
			return
			
		VariableStorage.coins -= VariableStorage.water_price
		VariableStorage.water += water_to_add
		VariableStorage.water_purchased += water_to_add
		_check_bulk_water_unlock_counter()
		_update_game_labels()
		
		if water_to_add < 90:
			print("Only added " + str(water_to_add) + " water due to capacity limits")
	else:
		print("Not enough coins to purchase water")


# Crop Buttons

func _on_sell_one_crop_button_pressed() -> void:
	print("Sell One Crop button pressed")
	if VariableStorage.crops > 0:
		VariableStorage.crops -= 1
		VariableStorage.coins += VariableStorage.crop_price
		VariableStorage.crops_sold += 1
		VariableStorage.coins_earned += VariableStorage.crop_price
		_update_game_labels()
	else:
		print("Not enough crops to sell")

func _on_sell_three_crop_button_pressed() -> void:
	print("Sell Three Crop button pressed")
	if VariableStorage.crops >= 3:
		VariableStorage.crops -= 3
		VariableStorage.coins += VariableStorage.crop_price * 3
		VariableStorage.crops_sold += 3
		VariableStorage.coins_earned += VariableStorage.crop_price * 3
		_update_game_labels()
	else:
		print("Not enough crops to sell")

func _on_sell_nine_crop_button_pressed() -> void:
	print("Sell Nine Crop button pressed")
	if VariableStorage.crops >= 9:
		VariableStorage.crops -= 9
		VariableStorage.coins += VariableStorage.crop_price * 9
		VariableStorage.crops_sold += 9
		VariableStorage.coins_earned += VariableStorage.crop_price * 9
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


# Buy Click Upgrade Button

func _on_buy_click_upgrade_button_pressed() -> void:
	match VariableStorage.click_upgrade_mk:
		0:  # Buying Mk 1
			if VariableStorage.coins >= VariableStorage.click_upgrade_price:
				VariableStorage.coins -= VariableStorage.click_upgrade_price
				VariableStorage.click_upgrade_mk = 1
				VariableStorage.mkOne_purchased = true
				buy_click_upgrade_button.disabled = true
				mkOne_toggle.disabled = false
				VariableStorage.click_upgrade_price_modifier += 4
				VariableStorage.click_upgrade_price = VariableStorage.click_upgrade_price * VariableStorage.click_upgrade_price_modifier
				_update_game_labels()
		1:  # Buying Mk 2
			if VariableStorage.coins >= VariableStorage.click_upgrade_price:
				VariableStorage.coins -= VariableStorage.click_upgrade_price
				VariableStorage.click_upgrade_mk = 2
				VariableStorage.mkTwo_purchased = true
				buy_click_upgrade_button.disabled = true
				mkTwo_toggle.disabled = false
				VariableStorage.click_upgrade_price_modifier += 5
				VariableStorage.click_upgrade_price = VariableStorage.click_upgrade_price * VariableStorage.click_upgrade_price_modifier
				_update_game_labels()
		2:  # Buying Mk 3
			if VariableStorage.coins >= VariableStorage.click_upgrade_price:
				VariableStorage.coins -= VariableStorage.click_upgrade_price
				VariableStorage.click_upgrade_mk = 3
				VariableStorage.mkThree_purchased = true
				buy_click_upgrade_button.disabled = true
				mkThree_toggle.disabled = false
				click_mk_label.text = "MAX"
				click_price_label.text = "N/A"
				_update_game_labels()

func _on_buy_water_cap_upgrade_button_pressed() -> void:
	if VariableStorage.coins >= VariableStorage.water_cap_upgrade_price:
		VariableStorage.coins -= VariableStorage.water_cap_upgrade_price
		VariableStorage.water_cap_mk_purchased += 1
		VariableStorage.water_cap_upgrade_mk += 1
		VariableStorage.water_cap_upgrade_price_modifier += 0.1
		VariableStorage.water_cap += 10
		VariableStorage.water_cap_upgrade_price = VariableStorage.WATER_CAP_UPGRADE_BASE_PRICE * VariableStorage.water_cap_upgrade_price_modifier
		buy_click_upgrade_button.disabled = true
		_update_game_labels()
	else:
		print("Not enough coins to purchase water cap upgrade")

# ----------------------------------------  Upgrade Unlock Checks ----------------------------------------  #

func _check_all_unlock_counters() -> void:
	_check_bulk_seed_unlock_counter()
	_check_bulk_water_unlock_counter()
	_check_bulk_crop_unlock_counter()
	_check_plots_clicked_counter()
	_check_click_upgrades_purchased()
	_check_water_used_counter()


func _check_bulk_seed_unlock_counter() -> void:
	if VariableStorage.seeds_purchased >= 50:
		buy_three_seed_button.disabled = false
		if VariableStorage.seeds_purchased >= 150:
			buy_nine_seed_button.disabled = false

func _check_bulk_water_unlock_counter() -> void:
	if VariableStorage.water_purchased >= 1000:
		buy_thirty_water_button.disabled = false
		if VariableStorage.water_purchased >= 3000:
			buy_ninety_water_button.disabled = false

func _check_bulk_crop_unlock_counter() -> void:
	if VariableStorage.crops_sold >= 50:
		sell_three_crop_button.disabled = false
		if VariableStorage.crops_sold >= 150:
			sell_nine_crop_button.disabled = false

func _check_plots_clicked_counter() -> void:
	if VariableStorage.plots_clicked >= 100:
		UpgradesStoreContainer.visible = true
		BuyClickUpgradeContainer.visible = true
		if !VariableStorage.mkOne_purchased:
			buy_click_upgrade_button.disabled = false
			VariableStorage.click_upgrade_price = VariableStorage.CLICK_UPGRADE_BASE_PRICE
			click_price_label.text = str(VariableStorage.click_upgrade_price)
		elif VariableStorage.plots_clicked >= 500 && !VariableStorage.mkTwo_purchased:
			buy_click_upgrade_button.disabled = false
			VariableStorage.click_upgrade_price = VariableStorage.CLICK_UPGRADE_BASE_PRICE * 5
			click_price_label.text = str(VariableStorage.click_upgrade_price)
		elif VariableStorage.plots_clicked >= 1000 && !VariableStorage.mkThree_purchased:
			buy_click_upgrade_button.disabled = false
			VariableStorage.click_upgrade_price = VariableStorage.CLICK_UPGRADE_BASE_PRICE * 10
			click_price_label.text = str(VariableStorage.click_upgrade_price)	

func _check_click_upgrades_purchased() -> void:
	if VariableStorage.mkOne_purchased:
		mkOne_toggle.disabled = false
	if VariableStorage.mkTwo_purchased:
		mkTwo_toggle.disabled = false
	if VariableStorage.mkThree_purchased:
		mkThree_toggle.disabled = false

func _check_water_used_counter() -> void:
	if VariableStorage.water_used >= 100:
		UpgradesStoreContainer.visible = true
		BuyWaterUpgradesContainer.visible = true

		@warning_ignore("integer_division")
		var current_water_tier: int = int(VariableStorage.water_used / 100)

		if current_water_tier >= VariableStorage.water_cap_upgrade_mk:
			buy_water_cap_upgrade_button.disabled = false
			VariableStorage.water_cap_mk_unlocked = current_water_tier
		else:
			buy_water_cap_upgrade_button.disabled = true

