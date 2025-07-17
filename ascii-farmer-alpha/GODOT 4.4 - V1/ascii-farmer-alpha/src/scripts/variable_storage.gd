extends Node

# Inventory Variables
var coins: float = 10.00

var fertilizer: int = 0

var yenSeeds: int = 1
var poundSeeds: int = 2
var euroSeeds: int = 3

var yenCrops: int = 1
var poundCrops: int = 2
var euroCrops: int = 3

var water: int = 10
var waterCap: int = 10

# Tool Variables
const TOOL_NONE: String = "None"
const TOOL_HOE: String = "Hoe"
const TOOL_SEED_BAG: String = "Seed Bag"
const TOOL_WATERING_CAN: String = "Watering\nCan"
const TOOL_SICKLE: String = "Sickle"

# Upgrade Variables
var ECmk1: bool = false
var ECmk2: bool = false
var ECmk3: bool = false

# Store Variables
var yenSeedCost: float = 1.00
var poundSeedCost: float = 1.00
var euroSeedCost: float = 1.00

var FertCost: float = 1.00
var WaterCost: float = 1.00

var yenCropPrice: float = 1.00
var poundCropPrice: float = 1.00
var euroCropPrice: float = 1.00