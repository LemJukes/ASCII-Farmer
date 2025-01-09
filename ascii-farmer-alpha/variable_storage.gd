# variable_storage.gd - A simple script to store variables in a dictionary

extends Node

# ----------------------------------------  System Functions  ---------------------------------------- #

func reset_game_data() -> void:

	# Inventory
	coins = START_COINS
	seeds = START_SEEDS
	crops = START_CROPS
	water = START_WATER
	water_cap = START_WATER_CAP
	
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
	water_cap_upgrade_price_modifier = 1.1

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
	water_cap_upgrade_mk = 1
	water_cap_mk_unlocked = 0
	water_cap_mk_purchased = 0


# Inventory Variables
const START_COINS: float = 10
const START_SEEDS = 1
const START_CROPS = 1
const START_WATER = 10
const START_WATER_CAP = 10

var coins: float = START_COINS
var seeds: int = START_SEEDS
var crops: int = START_CROPS
var water: int = START_WATER
var water_cap: int = START_WATER_CAP

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
const CROP_BASE_PRICE = 2

const BASE_PRICE_MODIFIER = 1.0

var seed_price_modifier: float = BASE_PRICE_MODIFIER
var water_price_modifier: float = BASE_PRICE_MODIFIER
var crop_price_modifier: float = BASE_PRICE_MODIFIER

var seed_price: float = SEED_BASE_PRICE * seed_price_modifier
var water_price: float = WATER_BASE_PRICE * water_price_modifier
var crop_price: float = CROP_BASE_PRICE * crop_price_modifier

# Plot Pricing Variables
const PLOT_BASE_PRICE = 10
const PLOT_PRICE_MODIFIER = 1.0
var plot_price: float = PLOT_BASE_PRICE

# Upgrade Pricing Variables
const WATER_CAP_UPGRADE_BASE_PRICE = 10
const CLICK_UPGRADE_BASE_PRICE = 100

var click_upgrade_price_modifier: float = 1.0
var water_cap_upgrade_price_modifier: float = 1.1

var click_upgrade_price: float = CLICK_UPGRADE_BASE_PRICE
var water_cap_upgrade_price: float = WATER_CAP_UPGRADE_BASE_PRICE

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

var water_cap_upgrade_mk: int = 1
var water_cap_mk_unlocked: int = 0
var water_cap_mk_purchased: int = 0

var click_upgrade_mk: int = 0

var mkOne_purchased: bool = false
var mkTwo_purchased: bool = false
var mkThree_purchased: bool = false

var mkOne_toggle_ON: bool = false
var mkTwo_toggle_ON: bool = false
var mkThree_toggle_ON: bool = false