# variable_storage.gd - A simple script to store variables in a dictionary

extends Node

# ----------------------------------------  System Functions  ---------------------------------------- #

func reset_game_data() -> void:
    # Game Timer Variables
    start_time = 0.0
    quit_time = 0.0
    resume_time = 0.0
    elapsed_time = 0.0

    # Inventory Variables
    coins = START_COINS
    seeds = START_SEEDS
    crops = START_CROPS
    water = START_WATER
    water_cap = START_WATER_CAP
    
    # Tool Variables
    current_tool = TOOL_NONE
    
    # Store Variables
    # Supplies Variables
    seed_price_modifier = BASE_PRICE_MODIFIER
    water_price_modifier = BASE_PRICE_MODIFIER
    crop_price_modifier = BASE_PRICE_MODIFIER
    
    seed_price = SEED_BASE_PRICE * seed_price_modifier
    water_price = WATER_BASE_PRICE * water_price_modifier
    crop_price = CROP_BASE_PRICE * crop_price_modifier
    
    # Plot Variables
    plot_price = PLOT_BASE_PRICE
    
    # Upgrade Variables
    click_mk = 0
    bulk_seed_mk = 0
    bulk_water_mk = 0
    bulk_crop_mk = 0
    
    click_upgrade_price = CLICK_UPGRADE_BASE_PRICE
    bulk_seed_upgrade_price = BULK_SEED_UPGRADE_BASE_PRICE
    bulk_water_upgrade_price = BULK_WATER_UPGRADE_BASE_PRICE
    bulk_crop_upgrade_price = BULK_CROP_UPGRADE_BASE_PRICE
    
    # Field Variables

    # Plot Variables

    # Unlock Counter Variables
    # Inventory Counters
    coins_earned = 0
    seeds_collected = 0
    crops_harvested = 0
    water_used = 0
    
    # Tool Counters
    plow_used = 0
    watering_can_used = 0
    scythe_used = 0
    
    # Store Counters
    seeds_purchased = 0
    water_purchased = 0
    crops_sold = 0
    
    # Field Counters
    plots_purchased = 0
    plots_tilled = 0
    plots_planted = 0
    plots_watered = 0
    plots_harvested = 0

# Game Timer Variables
var start_time: float = 0.0
var quit_time: float = 0.0
var resume_time: float = 0.0
var elapsed_time: float = 0.0

# Inventory Variables
const START_COINS: float = 10
const START_SEEDS = 10
const START_CROPS = 10
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
const TOOL_WATER = "Watering Can"
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

# Plot Variables
const PLOT_BASE_PRICE = 10
const PLOT_PRICE_MODIFIER = 1.0
var plot_price: float = PLOT_BASE_PRICE

# Upgrade Variables
var click_mk: int = 0
var bulk_seed_mk: int = 0
var bulk_water_mk: int = 0
var bulk_crop_mk: int = 0

const CLICK_UPGRADE_BASE_PRICE = 10
const BULK_SEED_UPGRADE_BASE_PRICE = 10
const BULK_WATER_UPGRADE_BASE_PRICE = 10
const BULK_CROP_UPGRADE_BASE_PRICE = 10

const CLICK_UPGRADE_PRICE_MODIFIER = 1.0
const BULK_SEED_UPGRADE_PRICE_MODIFIER = 1.0
const BULK_WATER_UPGRADE_PRICE_MODIFIER = 1.0
const BULK_CROP_UPGRADE_PRICE_MODIFIER = 1.0

var click_upgrade_price: float = CLICK_UPGRADE_BASE_PRICE
var bulk_seed_upgrade_price: float = BULK_SEED_UPGRADE_BASE_PRICE
var bulk_water_upgrade_price: float = BULK_WATER_UPGRADE_BASE_PRICE
var bulk_crop_upgrade_price: float = BULK_CROP_UPGRADE_BASE_PRICE

# Field Variables

# Plot Variables

# Unlock Counter Variables
# Inventory Counters
var coins_earned: float = 0
var seeds_collected: int = 0
var crops_harvested: int = 0
var water_used: int = 0

# Tool Counters
var plow_used: int = 0
var watering_can_used: int = 0
var scythe_used: int = 0

# Store Counters
var seeds_purchased: int = 0
var water_purchased: int = 0
var crops_sold: int = 0

# Field Counters
var plots_purchased: int = 0
var plots_tilled: int = 0
var plots_planted: int = 0
var plots_watered: int = 0
var plots_harvested: int = 0
