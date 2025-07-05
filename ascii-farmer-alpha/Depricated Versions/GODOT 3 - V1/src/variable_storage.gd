# variable_storage.gd - A simple script to store variables in a dictionary

extends Node

# ----------------------------------------  System Functions  ---------------------------------------- #

func add_coins(amount: float) -> void:
	coins += amount
	coins_earned += amount
	
	# Check for win condition
	if coins_earned >= 10000:
		is_game_paused = true
		var time = time_elapsed_game
		
		# Calculate time components for formatting
		var total_seconds = int(time)
		var milliseconds = int((time - total_seconds) * 10000)
		@warning_ignore("integer_division")
		var hours = total_seconds / 3600
		@warning_ignore("integer_division")
		var minutes = (total_seconds % 3600) / 60
		var seconds = total_seconds % 60
		
		# Format the time string
		var time_string = "%02d:%02d:%02d.%04d" % [hours, minutes, seconds, milliseconds]
		
		NotificationManager.show_notification(
			"Congratulations! You've Won!", 
			"You've reached 10,000 coins earned!\n\n" +
			"Final Time: " + time_string + "\n\n" +
			"Take a screenshot to share with your friends!\n\n" +
			"You can press Start to continue playing or Reset to start over."
		)

func reset_game_data() -> void:

	# System
	time_elapsed_game = 0
	is_game_paused = false

	# Notification
	mkOne_notification_shown = false
	mkTwo_notification_shown = false
	mkThree_notification_shown = false
	tool_changer_notification_shown = false

	# Inventory
	coins = START_COINS
	seeds = START_SEEDS
	crops = START_CROPS
	water = START_WATER
	water_cap = START_WATER_CAP
	tc_charge = START_TC_CHARGE
	tc_charge_cap = START_TC_CHARGE_CAP
	
	# Tools
	current_tool = TOOL_NONE
	
	# Store
	seed_price_modifier = BASE_PRICE_MODIFIER
	water_price_modifier = BASE_PRICE_MODIFIER
	crop_price_modifier = BASE_PRICE_MODIFIER
	
	seed_price = SEED_BASE_PRICE * seed_price_modifier
	water_price = WATER_BASE_PRICE * water_price_modifier
	crop_price = CROP_BASE_PRICE * crop_price_modifier
	
	click_upgrade_price = CLICK_UPGRADE_BASE_PRICE
	click_upgrade_price_modifier = 1.0

	water_cap_upgrade_price = WATER_CAP_UPGRADE_BASE_PRICE
	water_cap_upgrade_price_modifier = 1

	tc_upgrade_price = TC_UPGRADE_BASE_PRICE
	tc_upgrade_price_modifier = 1.0

	plot_price = PLOT_BASE_PRICE
	
	# Field
	plot_count = 0

	# Unlock Counters
	coins_earned = 0
	crops_harvested = 0
	plow_used = 0
	water_used = 0
	seeds_purchased = 0
	water_purchased = 0
	crops_sold = 0
	plots_purchased = 0
	plots_clicked = 0

	# Upgrade
	click_upgrade_mk = 0
	mkOne_purchased = false
	mkTwo_purchased = false
	mkThree_purchased = false
	mkOne_toggle_ON = false
	mkTwo_toggle_ON = false
	mkThree_toggle_ON = false
	water_cap_upgrade_mk = 0
	water_cap_mk_unlocked = 0
	water_cap_mk_purchased = 0
	tc_upgrade_mk = 0
	tc_mk_unlocked = 0
	tc_mk_purchased = 0
	tc_toggle_ON = false

# System Variables
var time_elapsed_app: float = 0
var time_game_started: float = 0
var time_elapsed_game: float = 0
var is_game_paused: bool = false

# Notification Variables
var mkOne_notification_shown: bool = false
var mkTwo_notification_shown: bool = false
var mkThree_notification_shown: bool = false
var tool_changer_notification_shown: bool = false

# Inventory Variables
const START_COINS: float = 10
const START_SEEDS = 1
const START_CROPS = 1
const START_WATER = 10
const START_WATER_CAP = 10
const START_TC_CHARGE = 10
const START_TC_CHARGE_CAP = 0

var coins: float = START_COINS
var seeds: int = START_SEEDS
var crops: int = START_CROPS
var water: int = START_WATER
var water_cap: int = START_WATER_CAP
var tc_charge: int = START_TC_CHARGE
var tc_charge_cap: int = START_TC_CHARGE_CAP

# Tool Variables
var current_tool: String = TOOL_NONE
const TOOL_NONE = "None"
const TOOL_PLOW = "Plow"
const TOOL_WATERING_CAN = "Watering Can"
const TOOL_SCYTHE = "Scythe"

# Store Variables
# Supplies Variables
const SEED_BASE_PRICE = 1
const WATER_BASE_PRICE = 1
const CROP_BASE_PRICE = 2.5

const BASE_PRICE_MODIFIER = 1.00

var seed_price_modifier: float = BASE_PRICE_MODIFIER - 1
var water_price_modifier: float = BASE_PRICE_MODIFIER - 1
var crop_price_modifier: float = BASE_PRICE_MODIFIER

var seed_price: float = SEED_BASE_PRICE * seed_price_modifier
var water_price: float = WATER_BASE_PRICE * water_price_modifier
var crop_price: float = CROP_BASE_PRICE * crop_price_modifier

# Plot Pricing Variables
const PLOT_BASE_PRICE = 10
const PLOT_PRICE_MODIFIER = 1.0
var plot_price: float = PLOT_BASE_PRICE

# Upgrade Pricing Variables
const WATER_CAP_UPGRADE_BASE_PRICE: float = 10
const CLICK_UPGRADE_BASE_PRICE: float = 100
const TC_UPGRADE_BASE_PRICE: float = 100.0

var click_upgrade_price_modifier: float = 1.0
var water_cap_upgrade_price_modifier: float = 1.1

var click_upgrade_price: float = CLICK_UPGRADE_BASE_PRICE
var water_cap_upgrade_price: float = WATER_CAP_UPGRADE_BASE_PRICE

var tc_upgrade_price: float = TC_UPGRADE_BASE_PRICE
var tc_upgrade_price_modifier: float = 1.0

# Field Variables
var plot_count: int = 0

# Unlock Counter Variables
var coins_earned: float = 0
var crops_harvested: int = 0

var plow_used: int = 0
var water_used: int = 0

var seeds_purchased: int = 0
var water_purchased: int = 0
var crops_sold: int = 0

var plots_purchased: int = 0
var plots_clicked: int = 0

var water_cap_upgrade_mk: int = 0
var water_cap_mk_unlocked: int = 0
var water_cap_mk_purchased: int = 0

var tc_upgrade_mk: int = 0
var tc_mk_unlocked: int = 0
var tc_mk_purchased: int = 0

var click_upgrade_mk: int = 0

var mkOne_purchased: bool = false
var mkTwo_purchased: bool = false
var mkThree_purchased: bool = false

var mkOne_toggle_ON: bool = false
var mkTwo_toggle_ON: bool = false
var mkThree_toggle_ON: bool = false

var tc_toggle_ON: bool = false