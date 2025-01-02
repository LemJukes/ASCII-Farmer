func load_nonplot_game_data() -> void:
	var save_data = SaveManager.load_game_data()
	if !save_data.is_empty():
		print("Loading Save Data:", save_data)
		
		# Inventory Data
		VariableStorage.coins = save_data["coins"]
		VariableStorage.seeds = save_data["seeds"]
		VariableStorage.crops = save_data["crops"]
		VariableStorage.water = save_data["water"]
		VariableStorage.water_cap = save_data["water_cap"]

		# Tool Data
		VariableStorage.current_tool = save_data["current_tool"]

		# Store Price Data
		VariableStorage.seed_price = save_data["seed_price"]
		VariableStorage.water_price = save_data["water_price"]
		VariableStorage.crop_price = save_data["crop_price"]
		VariableStorage.plot_price = save_data["plot_price"]

		# Field Data
		VariableStorage.plot_count = save_data["plot_count"]

		# Inventory Counters
		VariableStorage.coins_earned = save_data["coins_earned"]
		VariableStorage.seeds_collected = save_data["seeds_collected"] 
		VariableStorage.crops_harvested = save_data["crops_harvested"]
		VariableStorage.water_used = save_data["water_used"]
		
		# Tool Counters
		VariableStorage.plow_used = save_data["plow_used"]
		VariableStorage.watering_can_used = save_data["watering_can_used"]
		VariableStorage.scythe_used = save_data["scythe_used"]

		# Store Transaction Counters
		VariableStorage.seeds_purchased = save_data["seeds_purchased"]
		VariableStorage.water_purchased = save_data["water_purchased"]
		VariableStorage.crops_sold = save_data["crops_sold"]

		# Field Counters
		VariableStorage.plots_purchased = save_data["plots_purchased"]
		VariableStorage.plots_tilled = save_data["plots_tilled"]
		VariableStorage.plots_planted = save_data["plots_planted"]
		VariableStorage.plots_watered = save_data["plots_watered"]
		VariableStorage.plots_harvested = save_data["plots_harvested"]