extends Node

# Player Variables
var player_name: String = "Bean"

# Primary Inventory Variables
var coins: int = 10
var seeds: int = 10
var crops: int = 10
var water: int = 10
var watercap: int = 10 # limits the total amount of water the player can have.

# Tool Variables
var current_tool: String
const plow_tool: String = "Plow"
const water_tool: String = "Watering Can"
const scythe_tool: String = "Scythe"

var mk1_ison: bool = false
var mk2_ison: bool = false
var mk3_ison: bool = false

# Store Variables
# Prices
const seed_price: int = 1
const water_price: int = 1
const crop_price: int = 2
const plot_price_increase_factor: float = 1.33
var base_plot_price: float = 10

#Quantities
const seed_quant: int = 1
const water_quant: int = 10
const crop_quant: int = 1

# Upgrade Unlock Token Bool Variables
var mk1_isunlocked: bool = false
var mk2_isunlocked: bool = false
var mk3_isunlocked: bool = false

# Milestone Variables
# Inventory Milestones
var coins_earned: int = 0
# Tools & Upgrade Milestones
var changed_tool_count: int = 0
var toggle_ecu_count: int = 0
# Store Milesontes
var seeds_bought: int = 0
var water_refills_bought: int = 0
var crops_sold: int = 0
# Field Milestones
var plot_count: int = 0
# Plot Milestones
var plots_clicked: int = 0
var crop_loops_completed: int = 0
# System Milestones
