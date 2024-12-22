extends Control

#  ----------------------------------------  DEFAULT GODOT FUCNTIONS  ---------------------------------------- #

# Runs when the application is opened
func _ready() -> void:
	_connect_to_save_manager_signals()
	_initialize_game_labels()
	load_game()
	print("Game Application Opened at: ", _format_unix_time(Time.get_unix_time_from_system()))
	print("Game started at: ", _format_unix_time(VariableStorage.start_time))
	print("Game last resumed at: ", _format_unix_time(VariableStorage.resume_time))
	if FileAccess.file_exists(SaveManager.SAVE_FILE_PATH):
		VariableStorage.resume_time = Time.get_unix_time_from_system()
	print("Game last quit at: ", _format_unix_time(VariableStorage.quit_time))

func _process(_delta: float) -> void:
	if VariableStorage.start_time > 0.0:
		VariableStorage.elapsed_time = Time.get_unix_time_from_system() - VariableStorage.start_time
		_update_timer_display()

# ----------------------------------------  LABEL UI ELEMENT DECLARATIONS  ----------------------------------------  #

# System Label
@onready var game_timer_value_label: Label = %GameTimerValueLabel

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

# ----------------------------------------  Label UI Element Functions  ----------------------------------------  #

# Update Game Timer
func _update_timer_display() -> void:
	var hours := int(VariableStorage.elapsed_time / 3600)
	var minutes := int(VariableStorage.elapsed_time / 60) % 60
	var seconds := int(VariableStorage.elapsed_time) % 60
	var milliseconds := int(VariableStorage.elapsed_time * 1000) % 1000
	game_timer_value_label.text = "%02d:%02d:%02d.%03d" % [hours, minutes, seconds, milliseconds]

func update_game_labels() -> void:
	_update_inventory_labels()
	_update_tool_labels()
	_update_store_labels()

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

# ----------------------------------------  Button UI Element Declarations  ----------------------------------------  #

# System Buttons
@onready var start_button: Button = %StartButton
@onready var quit_button: Button = %QuitButton
@onready var reset_button: Button = %ResetButton

# ----------------------------------------  Game Initialization  ----------------------------------------  #

func _initialize_system_label() -> void:
	game_timer_value_label.text = "00:00:00.000"

func _initialize_game_labels() -> void:
	# Initialize the Inventory Labels
	coins_label.text = "0"
	seeds_label.text = "0"
	crops_label.text = "0"
	water_label.text = "0"
	water_cap_label.text = "0"

	# Initialize the Tool Labels
	current_tool_label.text = "--"

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

func save_game() -> void:
	var save_dict = {
		# Time Data
		"start_time": VariableStorage.start_time,
		"quit_time": VariableStorage.quit_time,
		"resume_time": VariableStorage.resume_time,

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
		"plots_harvested": VariableStorage.plots_harvested

	}
	SaveManager.save_game_data(save_dict)

func load_game() -> void:
	var save_data = SaveManager.load_game_data()
	if !save_data.is_empty():
		
		# This disables the start button and enables the reset button on a successful load
		start_button.disabled = true
		reset_button.disabled = false
		
		# Time Data
		VariableStorage.start_time = save_data["start_time"]
		VariableStorage.quit_time = save_data["quit_time"]
		VariableStorage.resume_time = save_data["resume_time"]

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
		
		print(" save_data: ", save_data)

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

func _format_unix_time(unix_time: float) -> String:
	var date_time = Time.get_datetime_dict_from_unix_time(int(unix_time))
	return "%d-%02d-%02d %02d:%02d:%02d (UTC)" % [
		date_time["year"],
		date_time["month"],
		date_time["day"],
		date_time["hour"],
		date_time["minute"],
		date_time["second"]
	]

# ----------------------------------------  System Buttons  ----------------------------------------  #.

func _on_start_button_pressed() -> void:
	# Hnadle button state changes
	start_button.disabled = true
	reset_button.disabled = false
	
	# Set game start time
	VariableStorage.start_time = Time.get_unix_time_from_system()
	print("Game started at: ", _format_unix_time(VariableStorage.start_time))

	# Save game data
	save_game()

func _on_reset_button_pressed() -> void:
	SaveManager.delete_save()

	VariableStorage.reset_game_data()

	_initialize_game_labels()

	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	VariableStorage.quit_time = Time.get_unix_time_from_system()
	print("Game quit at: ", _format_unix_time(VariableStorage.quit_time))
	
	# If a save file exists, save the game data
	if FileAccess.file_exists(SaveManager.SAVE_FILE_PATH):
		save_game()
	
	# Quit the game
	get_tree().quit()
