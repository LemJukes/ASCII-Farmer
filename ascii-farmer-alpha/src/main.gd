extends Control

#  ----------------------------------------  DEFAULT GODOT FUCNTIONS  ---------------------------------------- #

# Runs when the application is opened
func _ready() -> void:
	_connect_to_save_manager_signals()
	_connect_button_signals()
	_setup_input_actions()
	_initialize_game_labels()
	_set_sys_buttons_gameOFF()
	
	if FileAccess.file_exists(SaveManager.SAVE_FILE_PATH):
		load_game()
		if !VariableStorage.is_game_paused:
			if VariableStorage.time_elapsed_game > 0:
				_set_start_time_from_save()
				_set_sys_buttons_gameON()
				_unlock_starting_buttons()
	else:
		_start_up_message()


func _process(delta: float) -> void:
	_process_time_elapsed_app(delta)
	if VariableStorage.time_elapsed_game > 0:
		_process_time_elapsed_game()
		_update_timer_display()

# ----------------------------------------  LABEL UI ELEMENT DECLARATIONS  ----------------------------------------  #

# System Labels
@onready var timer_display: Label = %TimerDisplay

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
@onready var UpgradesContainer = %UpgradesVBoxContainer
@onready var ClickUpgradeControlsContainer = %ClickUpgradeControlsVBoxContainer
@onready var StoreUpgradesContainer = %StoreUpgradesVBoxContainer

@onready var BuyWaterUpgradesContainer = %BuyWaterCapUpgradesVBoxContainer
@onready var water_cap_mk_label: Label = %WaterCapUpgradeMkLabel
@onready var water_cap_price_label: Label = %WaterCapUpgradePriceLabel

@onready var BuyClickUpgradeContainer = %BuyClickUpgradesVBoxContainer
@onready var click_mk_label: Label = %ClickUpgradeMkLabel
@onready var click_price_label: Label = %ClickUpgradePriceLabel

@onready var ToolChangerUpgradeControlsContainer = %ToolChangerUpgradeControlsVBoxContainer
@onready var tc_mk_value_label: Label = %TCMkValueLabel
@onready var tc_charge_cap_label: Label = %TCCapacityValueLabel
@onready var tc_charges_value_label: Label = %TCChargesValueLabel

@onready var BuyToolChangerUpgradeContainer = %BuyToolChangerUpgradeVBoxContainer
@onready var tool_changer_mk_label: Label = %ToolChangerMkLabel
@onready var tool_changer_price_label: Label = %ToolChangerPriceLabel
@onready var BuyToolChangerChargeContainer = %BuyToolChangerChargeVBoxContainer
@onready var tc_charge_price_label: Label = %TCChargePriceLabel

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
	_timestamp_printout()
	save_game()

func _update_inventory_labels() -> void:
	coins_label.text = str(VariableStorage.coins)
	seeds_label.text = str(VariableStorage.seeds)
	crops_label.text = str(VariableStorage.crops)
	water_label.text = str(VariableStorage.water)
	water_cap_label.text = str(VariableStorage.water_cap)
	tc_charges_value_label.text = str(VariableStorage.tc_charge)
	tc_charge_cap_label.text = str(VariableStorage.tc_charge_cap)

func _update_tool_labels() -> void:
	current_tool_label.text = VariableStorage.current_tool

func _update_store_labels() -> void:
	seed_price_label.text = str(VariableStorage.seed_price)
	water_price_label.text = str(VariableStorage.water_price)
	crop_price_label.text = str(VariableStorage.crop_price)
	plot_price_label.text = str(VariableStorage.plot_price)
	tool_changer_mk_label.text = str(VariableStorage.tc_upgrade_mk + 1)
	tool_changer_price_label.text = str(VariableStorage.tc_upgrade_price)
	tc_charge_price_label.text = str(VariableStorage.tc_upgrade_price)

func _update_upgrade_labels() -> void:
	water_cap_mk_label.text = str(VariableStorage.water_cap_mk_unlocked)
	water_cap_price_label.text = str(VariableStorage.water_cap_upgrade_price)

	click_mk_label.text = str(VariableStorage.click_upgrade_mk + 1)
	click_price_label.text = str(VariableStorage.click_upgrade_price)

	tc_mk_value_label.text = str(VariableStorage.tc_upgrade_mk)
	tc_charges_value_label.text = str(VariableStorage.tc_charge)

func _update_upgrade_toggles() -> void:
	mkOne_toggle.button_pressed = VariableStorage.mkOne_toggle_ON
	mkTwo_toggle.button_pressed = VariableStorage.mkTwo_toggle_ON
	mkThree_toggle.button_pressed = VariableStorage.mkThree_toggle_ON
	tc_control_toggle.button_pressed = VariableStorage.tc_toggle_ON	

func _timestamp_printout() -> void:
	print("This action occured at msec: " + str(VariableStorage.time_elapsed_app))

func _update_timer_display() -> void:
	var time = VariableStorage.time_elapsed_game

	# Get whole seconds and milliseconds
	var total_seconds = int(time)
	var milliseconds = int((time - total_seconds) * 10000)

	# Calculate hours, minutes, seconds
	@warning_ignore("integer_division")
	var hours = total_seconds / 3600
	@warning_ignore("integer_division")
	var minutes = (total_seconds % 3600) / 60
	var seconds = total_seconds % 60

	# Format with leading zeros
	var time_string = "%02d:%02d:%02d.%04d" % [hours, minutes, seconds, milliseconds]

	timer_display.text = time_string

# ----------------------------------------  Button UI Element Declarations  ----------------------------------------  #

# System Buttons
@onready var start_button: Button = %StartButton
@onready var quit_button: Button = %QuitButton
@onready var reset_button: Button = %ResetButton
@onready var pause_button: Button = %PauseButton

# Tool Buttons
@onready var plow_button: Button = %PlowButton
@onready var watering_can_button: Button = %WateringCanButton
@onready var scythe_button: Button = %ScytheButton

# Upgrade Toggles
@onready var mkOne_toggle: CheckButton = %MkOneControlToggle
@onready var mkTwo_toggle: CheckButton = %MkTwoControlToggle
@onready var mkThree_toggle: CheckButton = %MkThreeControlToggle

@onready var tc_control_toggle: CheckButton = %TCControlToggle

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

@onready var buy_tc_charge_button: Button = %BuyTCChargeButton

@onready var buy_click_upgrade_button: Button = %BuyClickUpgradeButton
@onready var buy_water_cap_upgrade_button: Button = %BuyWaterCapUpgradeButton
@onready var buy_tool_changer_upgrade_button: Button = %BuyToolChangerUpgradeButton

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
	"plot_9": "_on_plot_9_pressed",
	
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
	pause_button.pressed.connect(_on_pause_button_pressed)

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

	buy_tool_changer_upgrade_button.pressed.connect(_on_buy_tool_changer_upgrade_button_pressed)

func _connect_upgrade_button_signals() -> void:
	mkOne_toggle.toggled.connect(_on_mkOne_toggle_toggled)
	mkTwo_toggle.toggled.connect(_on_mkTwo_toggle_toggled)
	mkThree_toggle.toggled.connect(_on_mkThree_toggle_toggled)
	tc_control_toggle.toggled.connect(_on_tc_control_toggle_toggled)

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

func _start_up_message() -> void:
	NotificationManager.show_notification(
		"Welcome to ASCII Farmer!",
		"🌱 Plant and grow crops to earn coins!\n\n" +
		"How to Play:\n" +
		"1. Choose the right tool for the right task!\n" +
		"2. Click plots or use the numpad to interact with them\n" +
		"3. Wait for crops to grow and then harvest before they wither!\n" +
		"4. Sell mature crops for coins\n\n" +
		"Tips:\n" +
		"• Unlock upgrades by playing\n" +
		"• Watch for notifications about new features\n" +
		"• Use your coins to expand and upgrade"
	)
# ----------------------------------------  Save Manager  ---------------------------------------- #

# Step 1: Basic save with plot states
func save_game() -> void:
	var plot_states = []
	for plot in field_grid.get_children():
		plot_states.append(plot.current_state)
	
	var save_dict = {

		# System Data
		"time_elapsed_game": VariableStorage.time_elapsed_game,
		"is_game_paused": VariableStorage.is_game_paused,

		# Notification Data
		"mkOne_notification_shown": VariableStorage.mkOne_notification_shown,
		"mkTwo_notification_shown": VariableStorage.mkTwo_notification_shown,
		"mkThree_notification_shown": VariableStorage.mkThree_notification_shown,
		"tool_changer_notification_shown": VariableStorage.tool_changer_notification_shown,

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

		# Upgrade Counters
		"click_upgrade_mk": VariableStorage.click_upgrade_mk,

		"mkOne_purchased": VariableStorage.mkOne_purchased,
		"mkTwo_purchased": VariableStorage.mkTwo_purchased,
		"mkThree_purchased": VariableStorage.mkThree_purchased,

		"mkOne_toggle_ON": VariableStorage.mkOne_toggle_ON,
		"mkTwo_toggle_ON": VariableStorage.mkTwo_toggle_ON,
		"mkThree_toggle_ON": VariableStorage.mkThree_toggle_ON,

		"water_cap_upgrade_mk": VariableStorage.water_cap_upgrade_mk,
		"water_cap_mk_unlocked": VariableStorage.water_cap_mk_unlocked,
		"water_cap_mk_purchased": VariableStorage.water_cap_mk_purchased,

		"tc_upgrade_mk": VariableStorage.tc_upgrade_mk,
		"tc_mk_unlocked": VariableStorage.tc_mk_unlocked,
		"tc_mk_purchased": VariableStorage.tc_mk_purchased,
		"tc_charge_cap": VariableStorage.tc_charge_cap,
		"tc_charge": VariableStorage.tc_charge

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

		# System Data
		VariableStorage.time_elapsed_game = save_data["time_elapsed_game"]
		VariableStorage.is_game_paused = save_data["is_game_paused"]

		# Notification Data
		VariableStorage.mkOne_notification_shown = save_data["mkOne_notification_shown"]
		VariableStorage.mkTwo_notification_shown = save_data["mkTwo_notification_shown"]
		VariableStorage.mkThree_notification_shown = save_data["mkThree_notification_shown"]
		VariableStorage.tool_changer_notification_shown = save_data["tool_changer_notification_shown"]
		
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

		VariableStorage.tc_upgrade_mk = save_data["tc_upgrade_mk"]
		VariableStorage.tc_mk_unlocked = save_data["tc_mk_unlocked"]
		VariableStorage.tc_mk_purchased = save_data["tc_mk_purchased"]
		VariableStorage.tc_charge_cap = save_data["tc_charge_cap"]
		VariableStorage.tc_charge = save_data["tc_charge"]
		
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
	if !VariableStorage.is_game_paused:
		start_button.disabled = true
		reset_button.disabled = false
		pause_button.disabled = false
	else:
		start_button.disabled = false
		reset_button.disabled = false
		pause_button.disabled = true

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
	if VariableStorage.time_elapsed_game > 0:
		_set_start_time_from_save()
		VariableStorage.is_game_paused = false
	else:
		_set_start_time()
		VariableStorage.time_elapsed_game =+ 0.0000000001
	_unlock_starting_buttons()
	_check_all_unlock_counters()
	_update_game_labels()
	if field_grid.get_child_count() == 0:
		field_grid._add_first_plot()
	save_game()
	

func _on_reset_button_pressed() -> void:
	print("Reset button pressed")
	SaveManager.delete_save()
	VariableStorage.reset_game_data()
	_initialize_game_labels()
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	_handle_quit()

func _on_pause_button_pressed() -> void:
	save_game()
	pause_button.disabled = true
	start_button.disabled = false
	if !VariableStorage.is_game_paused:
		VariableStorage.is_game_paused = !VariableStorage.is_game_paused

func _set_sys_buttons_gameON() -> void:
	start_button.disabled = true
	reset_button.disabled = false
	pause_button.disabled = false

func _set_sys_buttons_gameOFF() -> void:
	start_button.disabled = false
	reset_button.disabled = true
	pause_button.disabled = true


# ----------------------------------------  Tool Buttons  ----------------------------------------  #

func _on_plow_button_pressed() -> void:
	if _game_paused_check(): return
	print("Plow button pressed")
	VariableStorage.current_tool = VariableStorage.TOOL_PLOW	
	_update_game_labels()

func _on_watering_can_button_pressed() -> void:
	if _game_paused_check(): return
	print("Watering Can button pressed")
	VariableStorage.current_tool = VariableStorage.TOOL_WATERING_CAN
	_update_game_labels()

func _on_scythe_button_pressed() -> void:
	if _game_paused_check(): return
	print("Scythe button pressed")
	VariableStorage.current_tool = VariableStorage.TOOL_SCYTHE
	_update_game_labels()

# ----------------------------------------  Upgrade Toggles  ----------------------------------------  #

func _on_mkOne_toggle_toggled(_button_presed: bool) -> void:
	if _game_paused_check(): return
	VariableStorage.mkOne_toggle_ON = _button_presed
	print("Mk. 1 toggle pressed" + str(VariableStorage.mkOne_toggle_ON))
	_update_game_labels()

func _on_mkTwo_toggle_toggled(_button_pressed: bool) -> void:
	if _game_paused_check(): return
	VariableStorage.mkTwo_toggle_ON = _button_pressed
	print("Mk. 2 toggle pressed" + str(VariableStorage.mkTwo_toggle_ON))
	_update_game_labels()

func _on_mkThree_toggle_toggled(_button_pressed: bool) -> void:
	if _game_paused_check(): return
	VariableStorage.mkThree_toggle_ON = true
	print("Mk. 3 toggle pressed" + str(VariableStorage.mkThree_toggle_ON))
	_update_game_labels()

func _on_tc_control_toggle_toggled(_button_pressed: bool) -> void:
	if _game_paused_check(): return
	VariableStorage.tc_toggle_ON = true
	print("Tool Changer toggle pressed" + str(VariableStorage.tc_toggle_ON))
	_update_game_labels()

# ----------------------------------------  Store Buttons  ----------------------------------------  #

# Supplies Buttons
# Seed Buttons

func _on_buy_one_seed_button_pressed() -> void:
	if _game_paused_check(): return
	print("Buy One Seed button pressed")
	if VariableStorage.coins >= VariableStorage.seed_price:
		VariableStorage.coins -= VariableStorage.seed_price
		VariableStorage.seeds += 1
		VariableStorage.seeds_purchased += 1
		_update_game_labels()
		
	else:
		print("Not enough coins to purchase seeds")
		NotificationManager.show_notification("Not enough coins", "You need " + str(VariableStorage.seed_price) + " coins to purchase seeds")

func _on_buy_three_seed_button_pressed() -> void:
	if _game_paused_check(): return
	print("Buy Three Seed button pressed")
	if VariableStorage.coins >= VariableStorage.seed_price:
		VariableStorage.coins -= VariableStorage.seed_price
		VariableStorage.seeds += 3
		VariableStorage.seeds_purchased += 3
		_update_game_labels()
		
	else:
		print("Not enough coins to purchase seeds")
		NotificationManager.show_notification("Not enough coins", "You need " + str(VariableStorage.seed_price * 3) + " coins to purchase seeds")

func _on_buy_nine_seed_button_pressed() -> void:
	if _game_paused_check(): return
	if VariableStorage.coins >= VariableStorage.seed_price:
		VariableStorage.coins -= VariableStorage.seed_price
		VariableStorage.seeds += 9
		VariableStorage.seeds_purchased += 9
		_update_game_labels()
		
	else:
		print("Not enough coins to purchase seeds")
		NotificationManager.show_notification("Not enough coins", "You need " + str(VariableStorage.seed_price * 9) + " coins to purchase seeds")


# Water Buttons

func _on_buy_ten_water_button_pressed() -> void:
	if _game_paused_check(): return
	print("Buy Ten Water button pressed")
	if VariableStorage.water >= VariableStorage.water_cap:
		print("Water storage is at capacity!")
		NotificationManager.show_notification("Water Storage Full", "Water storage is at capacity!")
		return
		
	if VariableStorage.coins >= VariableStorage.water_price:
		var space_remaining = VariableStorage.water_cap - VariableStorage.water
		var water_to_add = min(10, space_remaining)
		
		if water_to_add == 0:
			print("Cannot add more water - at capacity!")
			NotificationManager.show_notification("Water Storage Full", "Cannot add more water, storage is at capacity!")
			return
			
		VariableStorage.coins -= VariableStorage.water_price
		VariableStorage.water += water_to_add
		VariableStorage.water_purchased += water_to_add
		_update_game_labels()
		
		if water_to_add < 10:
			print("Only added " + str(water_to_add) + " water due to capacity limits")
			NotificationManager.show_notification("Water Storage Full", "Only added " + str(water_to_add) + " water due to capacity limits")
	else:
		print("Not enough coins to purchase water")
		NotificationManager.show_notification("Not enough coins", "You need " + str(VariableStorage.water_price) + " coins to purchase water")

func _on_buy_thirty_water_button_pressed() -> void:
	if _game_paused_check(): return
	print("Buy Thirty Water button pressed")
	if VariableStorage.water >= VariableStorage.water_cap:
		print("Water storage is at capacity!")
		NotificationManager.show_notification("Water Storage Full", "Water storage is at capacity!")
		return

	if VariableStorage.coins >= VariableStorage.water_price:
		var space_remaining = VariableStorage.water_cap - VariableStorage.water
		var water_to_add = min(30, space_remaining)
		
		if water_to_add == 0:
			print("Cannot add more water - at capacity!")
			NotificationManager.show_notification("Water Storage Full", "Cannot add more water, storage is at capacity!")
			return
			
		VariableStorage.coins -= VariableStorage.water_price
		VariableStorage.water += water_to_add
		VariableStorage.water_purchased += water_to_add
		_update_game_labels()
		
		if water_to_add < 30:
			print("Only added " + str(water_to_add) + " water due to capacity limits")
	else:
		print("Not enough coins to purchase water")
		NotificationManager.show_notification("Not enough coins", "You need " + str(VariableStorage.water_price) + " coins to purchase water")

func _on_buy_ninety_water_button_pressed() -> void:
	if _game_paused_check(): return
	print("Buy Ninety Water button pressed")
	if VariableStorage.water >= VariableStorage.water_cap:
		print("Water storage is at capacity!")
		NotificationManager.show_notification("Water Storage Full", "Water storage is at capacity!")
		return

	if VariableStorage.coins >= VariableStorage.water_price:
		var space_remaining = VariableStorage.water_cap - VariableStorage.water
		var water_to_add = min(90, space_remaining)
		
		if water_to_add == 0:
			print("Cannot add more water - at capacity!")
			NotificationManager.show_notification("Water Storage Full", "Cannot add more water, storage is at capacity!")
			return
			
		VariableStorage.coins -= VariableStorage.water_price
		VariableStorage.water += water_to_add
		VariableStorage.water_purchased += water_to_add
		_check_bulk_purchases()
		_update_game_labels()
		
		if water_to_add < 90:
			print("Only added " + str(water_to_add) + " water due to capacity limits")
			NotificationManager.show_notification("Water Storage Full", "Only added " + str(water_to_add) + " water due to capacity limits")
	else:
		print("Not enough coins to purchase water")
		NotificationManager.show_notification("Not enough coins", "You need " + str(VariableStorage.water_price) + " coins to purchase water")


# Crop Buttons

func _on_sell_one_crop_button_pressed() -> void:
	if _game_paused_check(): return
	print("Sell One Crop button pressed")
	if VariableStorage.crops > 0:
		VariableStorage.crops -= 1
		VariableStorage.add_coins(VariableStorage.crop_price)
		VariableStorage.crops_sold += 1
		_update_game_labels()
	else:
		print("Not enough crops to sell")
		NotificationManager.show_notification("Not enough crops", "You need at least 1 crop to sell")

func _on_sell_three_crop_button_pressed() -> void:
	if _game_paused_check(): return
	print("Sell Three Crop button pressed")
	if VariableStorage.crops >= 3:
		VariableStorage.crops -= 3
		VariableStorage.add_coins((VariableStorage.crop_price * 3) * VariableStorage.crop_price_modifier)
		VariableStorage.crops_sold += 3
		_update_game_labels()
	else:
		print("Not enough crops to sell")
		NotificationManager.show_notification("Not enough crops", "You need at least 3 crops to sell")

func _on_sell_nine_crop_button_pressed() -> void:
	if _game_paused_check(): return
	print("Sell Nine Crop button pressed")
	if VariableStorage.crops >= 9:
		VariableStorage.crops -= 9
		VariableStorage.add_coins((VariableStorage.crop_price * 9) * VariableStorage.crop_price_modifier)
		VariableStorage.crops_sold += 9
		_update_game_labels()
	else:
		print("Not enough crops to sell")
		NotificationManager.show_notification("Not enough crops", "You need at least 9 crops to sell")

# Buy Plot Button

func _on_buy_plot_button_pressed() -> void:
	if _game_paused_check(): return
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
		NotificationManager.show_notification("Not enough coins", "You need " + str(VariableStorage.plot_price) + " coins to purchase a plot")


# Buy Click Upgrade Button

func _on_buy_click_upgrade_button_pressed() -> void:
	if _game_paused_check(): return
	match VariableStorage.click_upgrade_mk:
		0:  # Buying Mk 1
			if VariableStorage.coins >= VariableStorage.click_upgrade_price:
				UpgradesContainer.visible = true
				ClickUpgradeControlsContainer.visible = true
				VariableStorage.coins -= VariableStorage.click_upgrade_price
				VariableStorage.click_upgrade_mk = 1
				VariableStorage.mkOne_purchased = true
				buy_click_upgrade_button.disabled = true
				mkOne_toggle.disabled = false
				NotificationManager.show_notification("Click Upgrade Purchased", "You can now use the Mk. 1 Click Upgrade!")
				VariableStorage.click_upgrade_price_modifier += 4
				VariableStorage.click_upgrade_price = VariableStorage.click_upgrade_price * VariableStorage.click_upgrade_price_modifier
				_update_game_labels()
			else:
				NotificationManager.show_notification("Insufficient Coins", 
					"You need " + str(VariableStorage.click_upgrade_price) + " coins to purchase Mk. 1 Click Upgrade!")
		1:  # Buying Mk 2
			if VariableStorage.coins >= VariableStorage.click_upgrade_price:
				VariableStorage.coins -= VariableStorage.click_upgrade_price
				VariableStorage.click_upgrade_mk = 2
				VariableStorage.mkTwo_purchased = true
				buy_click_upgrade_button.disabled = true
				mkTwo_toggle.disabled = false
				NotificationManager.show_notification("Click Upgrade Purchased", "You can now use the Mk. 2 Click Upgrade!")
				VariableStorage.click_upgrade_price_modifier += 5
				VariableStorage.click_upgrade_price = VariableStorage.click_upgrade_price * VariableStorage.click_upgrade_price_modifier
				_update_game_labels()
			else:
				NotificationManager.show_notification("Insufficient Coins", 
					"You need " + str(VariableStorage.click_upgrade_price) + " coins to purchase Mk. 2 Click Upgrade!")
		2:  # Buying Mk 3
			if VariableStorage.coins >= VariableStorage.click_upgrade_price:
				VariableStorage.coins -= VariableStorage.click_upgrade_price
				VariableStorage.click_upgrade_mk = 3
				VariableStorage.mkThree_purchased = true
				buy_click_upgrade_button.disabled = true
				mkThree_toggle.disabled = false
				NotificationManager.show_notification("Click Upgrade Purchased", "You can now use the Mk. 3 Click Upgrade!")
				click_mk_label.text = "MAX"
				click_price_label.text = "N/A"
				_update_game_labels()
			else:
				NotificationManager.show_notification("Insufficient Coins", 
					"You need " + str(VariableStorage.click_upgrade_price) + " coins to purchase Mk. 3 Click Upgrade!")

func _on_buy_water_cap_upgrade_button_pressed() -> void:
	if _game_paused_check(): return
	if VariableStorage.coins >= VariableStorage.water_cap_upgrade_price:
		VariableStorage.coins -= VariableStorage.water_cap_upgrade_price
		VariableStorage.water_cap_mk_purchased += 1
		VariableStorage.water_cap_upgrade_mk += 1
		VariableStorage.water_cap += 10
		
		# Calculate new price with cleaner rounding
		var base_price = VariableStorage.WATER_CAP_UPGRADE_BASE_PRICE
		var multiplier = pow(1.5, VariableStorage.water_cap_upgrade_mk)
		VariableStorage.water_cap_upgrade_price = roundf(base_price * multiplier)
		
		buy_click_upgrade_button.disabled = true
		NotificationManager.show_notification("Water Cap Upgrade Purchased", "Water Cap increased by 10!")
		_update_game_labels()
	else:
		print("Not enough coins to purchase water cap upgrade")
		NotificationManager.show_notification("Not enough coins", 
			"You need " + str(VariableStorage.water_cap_upgrade_price) + 
			" coins to purchase a water cap upgrade")

func _on_buy_tool_changer_upgrade_button_pressed() -> void:
	if _game_paused_check(): return
	
	if VariableStorage.coins >= VariableStorage.tc_upgrade_price:
		VariableStorage.coins -= VariableStorage.tc_upgrade_price
		VariableStorage.tc_mk_purchased += 1
		VariableStorage.tc_upgrade_mk += 1
		if VariableStorage.tc_charge_cap == 0:
			VariableStorage.tc_charge_cap = 10
		else:
			VariableStorage.tc_charge_cap += 10
		
		# Calculate new price with cleaner rounding
		var base_price = VariableStorage.TC_UPGRADE_BASE_PRICE
		var multiplier = pow(1.5, VariableStorage.tc_upgrade_mk)
		VariableStorage.tc_upgrade_price = roundf(base_price * multiplier)
		
		# First time purchase initialization
		if VariableStorage.tc_mk_purchased == 1:
			# Enable containers
			BuyToolChangerChargeContainer.visible = true
			UpgradesContainer.visible = true
			ToolChangerUpgradeControlsContainer.visible = true
			tc_control_toggle.disabled = false
			
			# Show initial tutorial notification
			NotificationManager.show_notification(
				"Tool Changer Unlocked!", 
				"When toggled ON, your tool selection will be automated.\nUse charges to automatically switch between tools."
			)
		else:
			# Regular upgrade notification
			NotificationManager.show_notification(
				"Tool Changer Upgrade Purchased", 
				"Tool Changer capacity increased by 10!"
			)
		
		buy_tool_changer_upgrade_button.disabled = true
		_update_game_labels()
	else:
		print("Not enough coins to purchase tool changer upgrade")
		NotificationManager.show_notification(
			"Not enough coins", 
			"You need " + str(VariableStorage.tc_upgrade_price) + 
			" coins to purchase a tool changer upgrade"
		)

# ----------------------------------------  Upgrade Unlock Checks ----------------------------------------  #

func _check_all_unlock_counters() -> void:
	_check_bulk_purchases()
	_check_click_upgrades()
	_check_water_cap_upgrades()
	_check_tool_usage()

func _check_bulk_purchases() -> void:
	# Check bulk seed unlocks
	if VariableStorage.seeds_purchased >= 150 && buy_nine_seed_button.disabled:
		buy_three_seed_button.disabled = false
		buy_nine_seed_button.disabled = false
		NotificationManager.show_notification("Bulk Seed Purchase Unlocked", "You can now buy 9 seeds at a time!")
	elif VariableStorage.seeds_purchased >= 50 && buy_three_seed_button.disabled:
		buy_three_seed_button.disabled = false
		NotificationManager.show_notification("Bulk Seed Purchase Unlocked", "You can now buy 3 seeds at a time!")

	# Check bulk water unlocks
	if VariableStorage.water_purchased >= 3000 && buy_ninety_water_button.disabled:
		buy_thirty_water_button.disabled = false
		buy_ninety_water_button.disabled = false
		NotificationManager.show_notification("Bulk Water Purchase Unlocked", "You can now buy 90 water at a time!")
	elif VariableStorage.water_purchased >= 1000 && buy_thirty_water_button.disabled:
		buy_thirty_water_button.disabled = false
		NotificationManager.show_notification("Bulk Water Purchase Unlocked", "You can now buy 30 water at a time!")

	# Check bulk crop unlocks
	if VariableStorage.crops_sold >= 150 && sell_nine_crop_button.disabled:
		sell_three_crop_button.disabled = false
		sell_nine_crop_button.disabled = false
		NotificationManager.show_notification("Bulk Crop Sale Unlocked", "You can now sell 9 crops at a time!")
	elif VariableStorage.crops_sold >= 50 && sell_three_crop_button.disabled:
		sell_three_crop_button.disabled = false
		NotificationManager.show_notification("Bulk Crop Sale Unlocked", "You can now sell 3 crops at a time!")

func _check_click_upgrades() -> void:
	if VariableStorage.plots_clicked < 1000:
		return

	StoreUpgradesContainer.visible = true
	BuyClickUpgradeContainer.visible = true

	# Update click upgrade availability based on progress
	if VariableStorage.plots_clicked >= 5000 && !VariableStorage.mkThree_purchased && !VariableStorage.mkThree_notification_shown:
		_unlock_click_upgrade(3, VariableStorage.CLICK_UPGRADE_BASE_PRICE * 10)
		VariableStorage.mkThree_notification_shown = true
	elif VariableStorage.plots_clicked >= 2500 && !VariableStorage.mkTwo_purchased && !VariableStorage.mkTwo_notification_shown:
		_unlock_click_upgrade(2, VariableStorage.CLICK_UPGRADE_BASE_PRICE * 5)
		VariableStorage.mkTwo_notification_shown = true
	elif !VariableStorage.mkOne_purchased && !VariableStorage.mkOne_notification_shown:
		_unlock_click_upgrade(1, VariableStorage.CLICK_UPGRADE_BASE_PRICE)
		VariableStorage.mkOne_notification_shown = true

	# Update toggle buttons based on purchases
	mkOne_toggle.disabled = !VariableStorage.mkOne_purchased
	mkTwo_toggle.disabled = !VariableStorage.mkTwo_purchased
	mkThree_toggle.disabled = !VariableStorage.mkThree_purchased

func _unlock_click_upgrade(mk: int, price: float) -> void:
	buy_click_upgrade_button.disabled = false
	VariableStorage.click_upgrade_price = price
	click_price_label.text = str(price)
	NotificationManager.show_notification("Click Upgrade Unlocked", 
		"You can now purchase Mk. " + str(mk) + " Click Upgrade!")

func _check_water_cap_upgrades() -> void:
	if VariableStorage.water_used < 10:
		return

	if !BuyWaterUpgradesContainer.visible:
		StoreUpgradesContainer.visible = true
		BuyWaterUpgradesContainer.visible = true
		VariableStorage.water_cap_mk_unlocked = 1
		buy_water_cap_upgrade_button.disabled = false
		NotificationManager.show_notification("Water Cap Upgrade Unlocked", 
			"You can now purchase Water Cap Upgrades!")
		_update_game_labels()
		return

	@warning_ignore("integer_division")
	var current_water_tier: int = int(VariableStorage.water_used / 10)
	
	if current_water_tier > VariableStorage.water_cap_mk_unlocked:
		VariableStorage.water_cap_mk_unlocked = current_water_tier
		buy_water_cap_upgrade_button.disabled = false
	else:
		buy_water_cap_upgrade_button.disabled = current_water_tier <= VariableStorage.water_cap_upgrade_mk

func _check_tool_usage() -> void:
	var tools_used = VariableStorage.plow_used + VariableStorage.water_used + VariableStorage.crops_harvested
	if tools_used < 100:
		return

	# Show containers
	StoreUpgradesContainer.visible = true
	BuyToolChangerUpgradeContainer.visible = true

	# Check for tool changer upgrade unlocks
	@warning_ignore("integer_division")
	var current_tc_tier: int = int(tools_used / 100)
	
	if current_tc_tier > VariableStorage.tc_mk_unlocked:
		VariableStorage.tc_mk_unlocked = current_tc_tier
		buy_tool_changer_upgrade_button.disabled = false
	else:
		buy_tool_changer_upgrade_button.disabled = current_tc_tier <= VariableStorage.tc_upgrade_mk

	# Only show notification first time
	if !VariableStorage.tool_changer_notification_shown:
		NotificationManager.show_notification(
			"Tool Changer Upgrade Unlocked", 
			"You can now purchase the Tool Changer upgrade!"
		)
		VariableStorage.tool_changer_notification_shown = true
		
# ----------------------------------------  Helper Functions ----------------------------------------  #

func _handle_quit() -> void:
	print("Quit button pressed - starting quit sequence")  # Verify function is called
	
	# If a save file exists, save the game data
	if FileAccess.file_exists(SaveManager.SAVE_FILE_PATH):
		print("Save file found. Saving game data before quitting.")
		save_game()
		# Add delay before quitting
		await get_tree().create_timer(0.1).timeout
		get_tree().quit()
	else:
		print("No save file found. Quitting without saving.")
		# Add delay before quitting
		await get_tree().create_timer(0.1).timeout
		get_tree().quit()

func _on_game_window_closed(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_handle_quit()

# ----------------------------------------  Timer Handling  ----------------------------------------  #

func _set_start_time() -> void:
	VariableStorage.time_game_started = VariableStorage.time_elapsed_app
	print("Game started at msec: " + str(VariableStorage.time_game_started))

func _process_time_elapsed_app(delta: float) -> void:
	VariableStorage.time_elapsed_app += delta

func _process_time_elapsed_game() -> void:
	if !VariableStorage.is_game_paused:
		VariableStorage.time_elapsed_game = VariableStorage.time_elapsed_app - VariableStorage.time_game_started
	
func _set_start_time_from_save() -> void:
	# Calculate what the start time should have been to get our saved elapsed time
	VariableStorage.time_game_started = VariableStorage.time_elapsed_app - VariableStorage.time_elapsed_game
	print("Game time restored from save - started at: " + str(VariableStorage.time_game_started))

func _game_paused_check() -> bool:
	if VariableStorage.is_game_paused:
		print("Game is paused")
		NotificationManager.show_notification("Paused", "The game is paused.")
		return true
	return false
