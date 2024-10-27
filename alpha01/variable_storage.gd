extends Node

var player_name: String = "Bean"

# Primary Inventory Variables
var coins: int = 100
var seeds: int = 10
var crops: int = 10
var water: int = 10
var watercap: int = 10 # limits the total amount of water the player can have.

# Tool Variables
var current_tool: String
var plow_tool: String = "Plow"
var water_tool: String = "Watering Can"
var scythe_tool: String = "Scythe"

var mk1_ison: bool = false
var mk2_ison: bool = false
var mk3_ison: bool = false

# Store Variables
# Prices
const seed_price: int = 1
const water_price: int = 1
const crop_price: int = 1
var base_plot_price: int = 10
var plot_price_increase_factor: int = 1.33

#Quantities
const seed_quant: int = 1
const water_quant: int = 10
const crop_quant: int = 1

# Upgrade Unlock Token Bool Variables
var mk1_isunlocked: bool = false
var mk2_isunlocked: bool = false
var mk3_isunlocked: bool = false
