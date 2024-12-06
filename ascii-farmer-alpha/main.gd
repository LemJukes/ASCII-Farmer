extends Control

# ------- Declarations ------- #

# Inventory Label Setup
@onready var coin_value: Label = %CoinsValueLabel 
@onready var seed_value: Label = %SeedsValueLabel
@onready var water_value: Label = %WaterValueLabel
@onready var water_cap_value: Label = %WaterCapValueLabel
@onready var crop_value: Label = %CropsValueLabel

# ------- Ready Function ------- #
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_startup()

# ------- Startup Functions ------- #
func _startup() -> void:
	_startup_inventory()
	_connect_to_save_manager_signals()
	_attempt_to_load_game()
	#_startup_store()
	#_startup_farm()	

# Start Up Game Timer
func _connect_to_save_manager_signals() -> void:
	SaveManager.save_completed.connect(_on_save_completed)
	SaveManager.load_completed.connect(_on_load_completed)
	SaveManager.save_error.connect(_on_save_error)
	SaveManager.load_error.connect(_on_load_error)

func _attempt_to_load_game() -> void:
	load_game()

# Start Up Inventory
func _startup_inventory() -> void:
	# Set fake initial inventory values
	coin_value.text = "0"
	seed_value.text = "0"
	water_value.text = "0"
	water_cap_value.text = "0"
	crop_value.text = "0"

# ------- System Functions ------- #
# Time, Time. Time! Time to understand, the world! Time to understand, the monster!
func get_system_time() -> float:
	return Time.get_unix_time_from_system()

# Saving & Loading Functions
# Save Game - Saves the current game state
func save_game() -> void:
	var save_dict = {
		"start_time": VariableStorage.start_time,
		"coins": VariableStorage.coins,
		"seeds": VariableStorage.seeds,
		"crops": VariableStorage.crops,
		"water": VariableStorage.water,
		"water_cap": VariableStorage.water_cap
	}
	SaveManager.save_game_data(save_dict)

func load_game() -> void:
	var save_data = SaveManager.load_game_data()
	if !save_data.is_empty():
		
		var start_button: Button = %StartButton
		start_button.disabled = true
		var reset_button: Button = %ResetButton
		reset_button.disabled = false
		
		VariableStorage.coins = save_data["coins"]
		VariableStorage.seeds = save_data["seeds"]
		VariableStorage.crops = save_data["crops"]
		VariableStorage.water = save_data["water"]
		VariableStorage.water_cap = save_data["water_cap"]

		update_inventory()
		print(" save_data: ", save_data)

# Signal handlers for SaveManager
func _on_save_completed() -> void:
	print("Game saved successfully")

func _on_load_completed() -> void:
	print("Game loaded successfully")

func _on_save_error(error_message: String) -> void:
	print("Save error: ", error_message)

func _on_load_error(error_message: String) -> void:
	print("Load error: ", error_message)


# System Button Functions
# Start Button
func _on_start_button_pressed() -> void:
	# Set the start time
	VariableStorage.start_time = get_system_time()
	# Disable the start button
	var start_button: Button = %StartButton
	start_button.disabled = true
	# Enable the reset button
	var reset_button: Button = %ResetButton
	reset_button.disabled = false
	# Update Inventory to show real initial values
	update_inventory()
	save_game()

# Reset Button
func _on_reset_button_pressed() -> void:
	SaveManager.delete_save()
	get_tree().reload_current_scene()
	pass # Replace with function body.

# Quit Button
func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


# ------- Game Functions ------- #

# Inventory Functions
# Update Inventory - Updates the inventory labels to show the current values
func update_inventory() -> void:
	coin_value.text = str(VariableStorage.coins)
	seed_value.text = str(VariableStorage.seeds)
	water_value.text = str(VariableStorage.water)
	water_cap_value.text = str(VariableStorage.water_cap)
	crop_value.text = str(VariableStorage.crops)
