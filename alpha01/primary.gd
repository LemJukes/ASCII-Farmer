extends Control

# System Variables
	# Player Name Vars
@onready var player_name = $StartWindow/Background/StartContentStack/PlayerInput/InputWindow/HBoxContainer/VBoxContainer/MarginContainer2/PlayerNameInput
@onready var player_name_display = $GameWindow/Background/GameWindowContentStack/GameSystemContentStack/SystemInfo/HBoxContainer/PlayerNameDisplay

# Game Timer Vars
@onready var game_timer = $GameWindow/Background/GameWindowContentStack/GameSystemContentStack/SystemInfo/HBoxContainer/GameTimer
@onready var game_timer_display = $GameWindow/Background/GameWindowContentStack/GameSystemContentStack/SystemInfo/HBoxContainer/GameTimeDisplay
var elapsed_time: float = 0.0

const ModalMessage = preload("res://modal_message.tscn")

# UI Variables
# Minimize Button Body Vars
@onready var inv_body = get_node("GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Inventory/Background/VBoxContainer/InvWindowContent")
@onready var tnu_body = get_node("GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/ToolsAndUpgrades/Background/VBoxContainer/TnUWindowContent")
@onready var str_body = get_node("GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Store/Background/VBoxContainer/StrWindowContent")
@onready var fld_body = get_node("GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Field/Background/VBoxContainer/FldWindowContent")

# Inventory Values
@onready var coin_value: Label = %CoinValLabel 
@onready var seed_value: Label = %SeedValLabel
@onready var water_value: Label = %WaterValLabel
@onready var water_cap_value: Label = %WaterCapValLabel
@onready var crop_value: Label = %CropValLabel

# Tool Vars
@onready var current_tool_value: Label = %CurrentToolValue

# Store Vars
@onready var plot_buy_button: Button = %PlotBuyButton

# Plot Vars
@onready var fld_handler: GridContainer = %FldHandler


# ------- Primary Function Group ------- #

func _ready() -> void:
	_set_game_timer_resolution()
	update_inventory()
	update_store()

func _set_game_timer_resolution():
	game_timer.wait_time = 0.01

func _process(delta: float) -> void:
	_update_game_timer_display()

func _update_game_timer_display():
	game_timer_display.text = format_time(elapsed_time)

func show_modal(title: String = "", message: String = "") -> void:
	var modal = ModalMessage.instantiate()
	add_child(modal)
	modal.show_message(title if not title.is_empty() else modal.default_title, message if not message.is_empty() else modal.default_message)

# -------- UI Function Group ------- #

# Game Content Window Minimize Functions
func _on_inv_min_button_pressed() -> void:
	inv_body.visible = not inv_body.visible

func _on_tn_u_min_button_pressed() -> void:
	tnu_body.visible = not tnu_body.visible

func _on_str_min_button_pressed() -> void:
	str_body.visible = not str_body.visible

func _on_fld_min_button_pressed() -> void:
	fld_body.visible = not fld_body.visible


# ------- Game Startup Funtions Group ------- #

func _on_start_button_pressed() -> void:
	print(vs.player_name)
	var start_window = $StartWindow
	start_window.visible = false
	var game_window = $GameWindow
	game_window.visible = true
	player_name_display.text = vs.player_name
	start_game_timer()
	
func _on_player_name_input_text_submitted(new_text: String) -> void:
	_on_start_button_pressed()

func start_game_timer() -> void:
	elapsed_time = 0.0
	game_timer.start()
	_on_game_timer_timeout()
	
func _on_game_timer_timeout() -> void:
	elapsed_time += 0.01
	
func format_time(seconds: float) -> String:
	var hours = int(seconds) / 3600
	var minutes = (int(seconds) % 3600) / 60
	var secs = int(seconds) % 60
	var milliseconds = int((seconds - int(seconds)) * 100)
	
	var hours_str = str(hours).pad_zeros(2)
	var minutes_str = str(minutes).pad_zeros(2)
	var secs_str = str(secs).pad_zeros(2)
	var millis_str = str(milliseconds).pad_zeros(2)
	
	return hours_str + ":" + minutes_str + ":" + secs_str + "." + millis_str

func update_inventory() -> void:
	coin_value.text = str(vs.coins)
	seed_value.text = str(vs.seeds)
	water_value.text = str(vs.water)
	water_cap_value.text = str(vs.watercap)
	crop_value.text = str(vs.crops)


# ------- Tool Function Group -------- #

func update_tools() -> void:
	current_tool_value.text = str(vs.current_tool)

func _on_plow_button_pressed() -> void:
	vs.current_tool = vs.plow_tool
	update_tools()

func _on_water_button_pressed() -> void:
	vs.current_tool = vs.water_tool
	update_tools()

func _on_scythe_button_pressed() -> void:
	vs.current_tool = vs.scythe_tool
	update_tools()

func _on_mk_1_check_button_toggled(toggled_on: bool) -> void:
	vs.mk1_ison = toggled_on
	print(vs.mk1_ison)

func _on_mk_2_check_button_toggled(toggled_on: bool) -> void:
	vs.mk2_ison = toggled_on
	print(vs.mk2_ison)

func _on_mk_3_check_button_toggled(toggled_on: bool) -> void:
	vs.mk3_ison = toggled_on
	print(vs.mk3_ison)


# ------- Store Function Group ------- #

func transaction_success_response() -> void:
	print("Joy! :]")

func transaction_fail_response() -> void:
	print("no joy :[")

func update_store():
	plot_buy_button.text = str(vs.base_plot_price) + " Coins"

# Seed Purchasing
func _on_1x_seed_button_pressed() -> void:
	var bulk_fac = 1
	if vs.coins >= (vs.seed_price * bulk_fac):
		vs.coins -= (vs.seed_price * bulk_fac)
		vs.seeds += (vs.seed_quant * bulk_fac)
		_inc_seeds_bought(bulk_fac)
		update_inventory()
		transaction_success_response()
	else:
		transaction_fail_response()

func _on_3x_seed_button_pressed() -> void:
	var bulk_fac = 3
	if vs.coins >= (vs.seed_price * bulk_fac):
		vs.coins -= (vs.seed_price * bulk_fac)
		vs.seeds += (vs.seed_quant * bulk_fac)
		_inc_seeds_bought(bulk_fac)
		update_inventory()
		transaction_success_response()
	else:
		transaction_fail_response()

func _on_9x_seed_button_pressed() -> void:
	var bulk_fac = 9
	if vs.coins >= (vs.seed_price * bulk_fac):
		vs.coins -= (vs.seed_price * bulk_fac)
		vs.seeds += (vs.seed_quant * bulk_fac)
		_inc_seeds_bought(bulk_fac)
		update_inventory()
		transaction_success_response()
	else:
		transaction_fail_response()

# Water Purchasing
func water_full_response() -> void:
	print("Watering Can is full!")
	return

func water_cap_check() -> void:
	if vs.water == vs.watercap:
		water_full_response()
		transaction_fail_response()
	else:
		_inc_water_refills_bought()
		var temp_water_val = vs.water + vs.water_quant
		if temp_water_val >= vs.watercap:
			vs.water = vs.watercap
			vs.coins -= vs.water_price
			water_full_response()
			transaction_success_response()
		else:
			vs.water = temp_water_val
			vs.coins -= vs.water_price
			transaction_success_response()

func water_cap_check_bulk3() -> void:
	if vs.water == vs.watercap:
		water_full_response()
		transaction_fail_response()
	else:
		_inc_water_refills_bought()
		var bulk_water_price = vs.water_price * 3
		var bulk_water_quant = vs.water_quant * 3
		var temp_water_val = vs.water + bulk_water_quant
		if temp_water_val >= vs.watercap:
			vs.water = vs.watercap
			vs.coins -= bulk_water_price
			water_full_response()
			transaction_success_response()
		else:
			vs.water = temp_water_val
			vs.coins -= bulk_water_price
			transaction_success_response()

func water_cap_check_bulk9() -> void:
	if vs.water == vs.watercap:
		water_full_response()
		transaction_fail_response()
	else:
		_inc_water_refills_bought()
		var bulk_water_price = vs.water_price * 9
		var bulk_water_quant = vs.water_quant * 9
		var temp_water_val = vs.water + bulk_water_quant
		if temp_water_val >= vs.watercap:
			vs.water = vs.watercap
			vs.coins -= bulk_water_price
			water_full_response()
			transaction_success_response()
		else:
			vs.water = temp_water_val
			vs.coins -= bulk_water_price
			transaction_success_response()

func _on_10x_water_button_pressed() -> void:
	if vs.coins >= vs.water_price:
		water_cap_check()
		update_inventory()
	else:
		transaction_fail_response()

func _on_30x_water_button_pressed() -> void:
	var bulk_water_price = (vs.water_price * 3)
	if vs.coins >= bulk_water_price:
		water_cap_check_bulk3()
		update_inventory()
	else:
		transaction_fail_response()

func _on_90x_water_button_pressed() -> void:
	var bulk_water_price = (vs.water_price * 9)
	if vs.coins >= bulk_water_price:
		water_cap_check_bulk9()
		update_inventory()
	else:
		transaction_fail_response()

# Crop Sales Function Group
func _on_1x_crop_button_pressed() -> void:
	var bulk_fac = 1
	if vs.crops >= bulk_fac:
		vs.crops -= bulk_fac
		vs.coins += bulk_fac
		_inc_crops_sold(bulk_fac)
		update_inventory()
		transaction_success_response()
	else:
		transaction_fail_response()
	
func _on_3x_crop_button_pressed() -> void:
	var bulk_fac = 3
	if vs.crops > bulk_fac:
		vs.crops -= bulk_fac
		vs.coins += bulk_fac
		_inc_crops_sold(bulk_fac)
		update_inventory()
		transaction_success_response()
	else:
		transaction_fail_response()

func _on_9x_crop_button_pressed() -> void:
	var bulk_fac = 9
	if vs.crops > bulk_fac:
		vs.crops -= bulk_fac
		vs.coins += bulk_fac
		_inc_crops_sold(bulk_fac)
		update_inventory()
		transaction_success_response()
	else:
		transaction_fail_response()

# Plot Purchasing Function Group
func _on_plot_buy_button_pressed():
	if fld_handler.check_plot_count() == true:
		if vs.coins >= vs.base_plot_price:
			vs.coins -= vs.base_plot_price
			var new_plot_price = ceili(vs.base_plot_price * vs.plot_price_increase_factor)
			vs.base_plot_price = new_plot_price
			print(str(vs.base_plot_price))
			update_store()
			update_inventory()
			fld_handler.add_plot()
			transaction_success_response()
		else:
			transaction_fail_response()

# Supply Upgrade Purchasing Function Group
func _on_buy_bulk_water_upgrade_button_pressed() -> void:
	pass # Replace with function body.

func _on_buy_bulk_seed_upgrade_button_pressed() -> void:
	pass # Replace with function body.

func _on_sell_bulk_crops_uograde_button_pressed() -> void:
	pass # Replace with function body.

# Click Upgrade Purchasing Function Group
func _on_buy_mk_1_button_pressed() -> void:
	pass # Replace with function body.

func _on_buy_mk_2_button_pressed() -> void:
	pass # Replace with function body.

func _on_buy_mk_3_button_pressed() -> void:
	pass # Replace with function body.

# ------- Primary Milstone Functions ------- #

func _inc_coins_earned(inc_amount: int) -> void:
	vs.coins_earned += inc_amount
	print("Total Coins Earned: " + str(vs.coins_earned))
	pass

func _inc_seeds_bought(inc_amount: int) -> void:
	vs.seeds_bought += inc_amount
	print("Total Seeds Bought: " + str(vs.seeds_bought))
	pass

func _inc_water_refills_bought():
	vs.water_refills_bought += 1
	print("Total Water Refills Bought: " + str(vs.water_refills_bought))
	pass

func _inc_crops_sold(inc_amount: int) -> void:
	vs.crops_sold += inc_amount
	print("Total Crops Sold: " + str(vs.crops_sold))
	pass
