extends Node

var player_name: String = "Bean"

# Primary Inventory Variables
var coins: int = 10
var seeds: int = 1
var crops: int = 1
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
var seed_price: int = 1
var water_price: int = 1
var crop_price: int = 1
var plot_price: int = 10
#Quantities
var seed_quant: int = 1
var water_quant: int = 10
var crop_quant: int = 1

# Upgrade Unlock Token Bool Variables
var mk1_isunlocked: bool = false
var mk2_isunlocked: bool = false
var mk3_isunlocked: bool = false
