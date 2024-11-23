extends Control

# ------- Declarations ------- #

# Game Timer Setup
@onready var game_timer_value: Label = %GameTimerValueLabel
var game_timer: Timer

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
	_connect_to_save_manager_signals()
	_attempt_to_load_game()
	_startup_game_timer()
	_startup_inventory()
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

func _startup_game_timer() -> void:
	# Set the game timer to 0
	VariableStorage.game_time_elapsed = 0.000
	# Create and setup timer node
	game_timer = Timer.new()
	game_timer.name = "GameTimer"
	game_timer.wait_time = 0.001 # 1ms resolution
	game_timer.timeout.connect(_on_game_timer_timeout)
	add_child(game_timer)
	# Set Initial Game Timer Value
	game_timer_value.text = "00:00:00.000"


# Start Up Inventory
func _startup_inventory() -> void:
	# Set fake initial inventory values
	coin_value.text = "0"
	seed_value.text = "0"
	water_value.text = "0"
	water_cap_value.text = "0"
	crop_value.text = "0"

# ------- System Functions ------- #

# Saving & Loading Functions
# Save Game - Saves the current game state
func save_game() -> void:
	var save_dict = {
		"game_time_elapsed": VariableStorage.game_time_elapsed,
	}
	SaveManager.save_game_data(save_dict)

func load_game() -> void:
	var save_data = SaveManager.load_game_data()
	if !save_data.is_empty():
		VariableStorage.game_time_elapsed = save_data["game_time_elapsed"]
		game_timer_value.text = format_time(VariableStorage.game_time_elapsed)

# Signal handlers for SaveManager
func _on_save_completed() -> void:
	print("Game saved successfully")

func _on_load_completed() -> void:
	print("Game loaded successfully")

func _on_save_error(error_message: String) -> void:
	print("Save error: ", error_message)

func _on_load_error(error_message: String) -> void:
	print("Load error: ", error_message)

# Game Timer Functions
# Game Timer Timeout - Updates the game timer value
func _on_game_timer_timeout() -> void:
	VariableStorage.game_time_elapsed += 0.001
	game_timer_value.text = format_time(VariableStorage.game_time_elapsed)
# Format Time - Formats a float time value into a string
func format_time(time: float) -> String:
	var hours = int(time / 3600)
	var minutes = int(time / 60) % 60
	var seconds = int(time) % 60
	var milliseconds = int(time * 1000) % 1000
	return "%02d:%02d:%02d.%03d" % [hours, minutes, seconds, milliseconds]

# System Button Functions
# Start Button
func _on_start_button_pressed() -> void:
	# Start the game timer
	VariableStorage.game_time_elapsed = 0.000
	game_timer.start()
	# Disable the start button
	var start_button: Button = %StartButton
	start_button.disabled = true
	# Enable the reset button
	var reset_button: Button = %ResetButton
	reset_button.disabled = false
	# Update Inventory to show real initial values
	update_inventory()

# Reset Button
func _on_reset_button_pressed() -> void:
	pass # Replace with function body.

# Quit Button
func _on_quit_button_pressed() -> void:
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


