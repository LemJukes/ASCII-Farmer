extends Control

# System Variables
	# Player Name Vars
@onready var player_name = $StartWindow/Background/StartContentStack/PlayerInput/InputWindow/HBoxContainer/VBoxContainer/MarginContainer2/PlayerNameInput
@onready var player_name_display = $GameWindow/Background/GameWindowContentStack/GameSystemContentStack/SystemInfo/HBoxContainer/PlayerNameDisplay

# Game Timer Vars
@onready var game_timer = $GameWindow/Background/GameWindowContentStack/GameSystemContentStack/SystemInfo/HBoxContainer/GameTimer
@onready var game_timer_display = $GameWindow/Background/GameWindowContentStack/GameSystemContentStack/SystemInfo/HBoxContainer/GameTimeDisplay
var elapsed_time: float = 0.0

# UI Variables
# Minimize Button Body Vars
@onready var inv_body = get_node("GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Inventory/Background/VBoxContainer/InvWindowContent")
@onready var tnu_body = get_node("GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/ToolsAndUpgrades/Background/VBoxContainer/TnUWindowContent")
@onready var str_body = get_node("GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Store/Background/VBoxContainer/StrWindowContent")
@onready var fld_body = get_node("GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Field/Background/VBoxContainer/FldWindowContent")

# Player Vars
# Primary Inventory Values
@onready var coin_value = $GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Inventory/Background/VBoxContainer/InvWindowContent/InvItems/VBoxContainer/InvItemValues/VBoxContainer/PanelContainer/CoinValLabel
@onready var seed_value = $GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Inventory/Background/VBoxContainer/InvWindowContent/InvItems/VBoxContainer/InvItemValues/VBoxContainer2/PanelContainer/SeedValLabel
@onready var water_value = $GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Inventory/Background/VBoxContainer/InvWindowContent/InvItems/VBoxContainer/InvItemValues/VBoxContainer3/PanelContainer/HBoxContainer/WaterValLabel
@onready var water_cap_value = $GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Inventory/Background/VBoxContainer/InvWindowContent/InvItems/VBoxContainer/InvItemValues/VBoxContainer3/PanelContainer/HBoxContainer/WaterCapValLabel
@onready var crop_value = $GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Inventory/Background/VBoxContainer/InvWindowContent/InvItems/VBoxContainer/InvItemValues/VBoxContainer4/PanelContainer/CropValLabel
# Tool Display Vars
@onready var current_tool_value = $GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/ToolsAndUpgrades/Background/VBoxContainer/TnUWindowContent/ToolButtons/VBoxContainer/HBoxContainer/MarginContainer4/VBoxContainer/PanelContainer2/CurrentToolValue


# ------- Primary Function Group ------- #

func _ready() -> void:
	game_timer.wait_time = 0.01
	update_inventory()
	
func _process(delta: float) -> void:
	game_timer_display.text = format_time(elapsed_time)
	

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

# Seed Purchasing
func _on_1x_seed_button_pressed() -> void:
	if vs.coins >= vs.seed_price:
		vs.coins -= vs.seed_price
		vs.seeds += vs.seed_quant
		update_inventory()
		transaction_success_response()
	else:
		transaction_fail_response()

func _on_3x_seed_button_pressed() -> void:
	var bulk_seed_price = vs.seed_price * 3
	var bulk_seed_quant = vs.seed_quant * 3
	if vs.coins >= bulk_seed_price:
		vs.coins -= bulk_seed_price
		vs.seeds += bulk_seed_quant
		update_inventory()
		transaction_success_response()
	else:
		transaction_fail_response()
		
func _on_9x_seed_button_pressed() -> void:
	var bulk_seed_price = vs.seed_price * 9
	var bulk_seed_quant = vs.seed_quant * 9
	if vs.coins >= bulk_seed_price:
		vs.coins -= bulk_seed_price
		vs.seeds += bulk_seed_quant
		update_inventory()
		transaction_success_response()
	else:
		transaction_fail_response()

# Water Purchasing
func _on_10x_water_button_pressed() -> void:
	if vs.coins >= vs.water_price:
		vs.coins -= vs.water_price
		vs.water += vs.water_quant
		update_inventory()
		transaction_success_response()
	else:
		transaction_fail_response()

func _on_30x_water_button_pressed() -> void:
	# ADD WATER CAP CHECK
	var bulk_water_price = vs.water_price * 3
	var bulk_water_quant = vs.water_quant * 3
	if vs.coins >= bulk_water_price:
		vs.coins -= bulk_water_price
		vs.water += bulk_water_quant
		update_inventory()
		transaction_success_response()
	else:
		transaction_fail_response()

func _on_90x_water_button_pressed() -> void:
	# ADD WATER CAP CHECK
	var bulk_water_price = vs.water_price * 9
	var bulk_water_quant = vs.water_quant * 9
	if vs.coins >= bulk_water_price:
		vs.coins -= bulk_water_price
		vs.water += bulk_water_quant
		update_inventory()
		transaction_success_response()
	else:
		transaction_fail_response()
		

# -------- UI Function Stack ------- #

# Game Content Stack Window Minimize Functions
func _on_inv_min_button_pressed() -> void:
	inv_body.visible = not inv_body.visible

func _on_tn_u_min_button_pressed() -> void:
	tnu_body.visible = not tnu_body.visible

func _on_str_min_button_pressed() -> void:
	str_body.visible = not str_body.visible

func _on_fld_min_button_pressed() -> void:
	fld_body.visible = not fld_body.visible
