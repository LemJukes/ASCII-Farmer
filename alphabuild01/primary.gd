extends Control

# Defines the "Inventory Currency Variables" Label Elements
@onready var coin_value = $"Main Window/MarginContainer/HBoxContainer/Menues/Inventory/CurrencyValues/CoinValue"
@onready var seeds_value = $"Main Window/MarginContainer/HBoxContainer/Menues/Inventory/CurrencyValues/SeedValue"
@onready var water_value = $"Main Window/MarginContainer/HBoxContainer/Menues/Inventory/CurrencyValues/WaterValue"
@onready var crop_value = $"Main Window/MarginContainer/HBoxContainer/Menues/Inventory/CurrencyValues/CropValue"

# Messaging Instantiation
@onready var seed_purchase_response = $"Main Window/MarginContainer/HBoxContainer/Menues/Store/StoreButtons/BuySeeds/SeedPurchaseResponseLabel"
@onready var water_purchase_response = $"Main Window/MarginContainer/HBoxContainer/Menues/Store/StoreButtons/BuyWater/WaterPurchaseResponseLabel"
@onready var crop_sale_response = $"Main Window/MarginContainer/HBoxContainer/Menues/Store/StoreButtons/SellCrops/CropSaleResponseLabel"

# Field Instantiation
@onready var field = $"Main Window/MarginContainer/HBoxContainer/Field"
var plot = preload("res://plot.tscn")

# On Run Functions
func _ready() -> void:
	
	# Sets currency value label text to starting variable on game start
	coin_value.text = str(VariableStorage.coins)
	seeds_value.text = str(VariableStorage.seeds)
	water_value.text = str(VariableStorage.water)
	crop_value.text = str(VariableStorage.crops)

	var buy_plot_button = $"Main Window/MarginContainer/HBoxContainer/Menues/Store/PanelContainer/BuyPlot"
	buy_plot_button.disabled = true

# Store Functions
# Purchase Response Messaging Function
# Seed Purchase Response
func seed_purchase_response_message(message: String, duration: float = 0.5) -> void:
	var seed_buy_button = $"Main Window/MarginContainer/HBoxContainer/Menues/Store/StoreButtons/BuySeeds/BuySeedsButton"
	seed_purchase_response.text = message
	seed_purchase_response.visible = true
	seed_buy_button.visible = false
	await get_tree().create_timer(duration).timeout
	seed_purchase_response.visible = false
	seed_buy_button.visible = true

# Water Puchase Response
func water_purchase_response_message(message: String, duration: float = 0.5) -> void:
	var water_buy_button = $"Main Window/MarginContainer/HBoxContainer/Menues/Store/StoreButtons/BuyWater/BuyWaterButton"
	water_purchase_response.text = message
	water_purchase_response.visible = true
	water_buy_button.visible = false
	await get_tree().create_timer(duration).timeout
	water_purchase_response.visible = false
	water_buy_button.visible = true

# Crop Sale Response
func crop_sale_response_message(message: String, duration: float = 0.5) -> void:
	var crop_sale_button = $"Main Window/MarginContainer/HBoxContainer/Menues/Store/StoreButtons/SellCrops/SellCropsButton"
	crop_sale_response.text = message
	crop_sale_response.visible = true
	crop_sale_button.visible = false
	await get_tree().create_timer(duration).timeout
	crop_sale_response.visible = false
	crop_sale_button.visible = true

#Store Buy/Sell Buttons
# Buy 1x Seeds Button
func _on_buy_seeds_button_pressed() -> void:
	if VariableStorage.coins >= VariableStorage.seedPrice:
		VariableStorage.coins -= VariableStorage.seedPrice
		coin_value.text = str(VariableStorage.coins)
		VariableStorage.seeds += VariableStorage.seedQuantity
		seeds_value.text = str(VariableStorage.seeds)
		seed_purchase_response_message("Purchase Successful!")
	else:
		seed_purchase_response_message("Not enough coins!")
		print("Not enough coins.")

# Buy 10x Water Button
func _on_buy_water_button_pressed() -> void:
	if VariableStorage.water == VariableStorage.waterCap:
		water_purchase_response_message("Water Full!")
	else:
		if VariableStorage.coins >= VariableStorage.waterPrice:
			var new_water_value = VariableStorage.water + VariableStorage.waterQuantity
			if new_water_value >= VariableStorage.waterCap:
				VariableStorage.water = VariableStorage.waterCap
				water_purchase_response_message("Water Filled!")
			else:
				VariableStorage.water = new_water_value
				water_purchase_response_message("Purchase Successful!")
			VariableStorage.coins -= VariableStorage.waterPrice
			coin_value.text = str(VariableStorage.coins)
			water_value.text = str(VariableStorage.water)
		else:
			water_purchase_response_message("Not enough coins!")
			print("Not enough coins.")

# Sell 1x Crop Button
func _on_sell_crops_button_pressed() -> void:
	if VariableStorage.crops > 0:
		VariableStorage.crops -= VariableStorage.cropQuantity
		crop_value.text = str(VariableStorage.crops)
		VariableStorage.coins += VariableStorage.cropPrice
		coin_value.text = str(VariableStorage.coins)
		crop_sale_response_message("Sale Successful!")
	else:
		crop_sale_response_message("No crops to sell!")
		print("No crops to sell!")

func _on_buy_plot_pressed() -> void:
	if VariableStorage.coins >= VariableStorage.plotPrice:
		var plot_instance = plot.instantiate()
		VariableStorage.coins -= VariableStorage.plotPrice
		coin_value.text = str(VariableStorage.coins)
		print("Current Coins: " + str(VariableStorage.coins))
		field.add_child(plot_instance)
	else:
		pass
