extends Control

# Minimize Button Body Variable Definitions
@onready var game_window = get_node("ScrollContainer/Primary-VBoxContainer/GameWindow")
@onready var sys_body = get_node("ScrollContainer/Primary-VBoxContainer/GameWindow/System-VBoxContainer")
@onready var inv_body = get_node("ScrollContainer/Primary-VBoxContainer/GameWindow/Inventory-VBoxContainer")
@onready var tnu_body = get_node("ScrollContainer/Primary-VBoxContainer/GameWindow/Tools&Upgrades-VBoxContainer")
@onready var str_body = get_node("ScrollContainer/Primary-VBoxContainer/GameWindow/Store-VBoxContainer")
@onready var fld_body = get_node("ScrollContainer/Primary-VBoxContainer/GameWindow/Field-VBoxContainer")

# Start Window Variable Definitions
@onready var start_window = get_node("ScrollContainer/GameWindow/Primary-VBoxContainer/StartWindow-PanelContainer")

# Currency Variable Definitions
var coins: int = 10


# Player Variable Definitions

#Gamestate Variable Definitions

# -------------- System Functions --------- #

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Inventory Variable Initialization
	var CoinValue = $"ScrollContainer/Primary-VBoxContainer/GameWindow/Inventory-VBoxContainer/CurrencyValues-InvSubHeader-PanelContainer/CurrencyValues-InvSubHeaderElements-MarginContainer/CurrencyValues-InvSubHeaderElements-HBoxContainer/CoinsValue-Label"
	CoinValue.text = " " + str(coins)

# -------------- Start Window Fucntions --------- #

func _on_start_button_pressed() -> void:
	# Debugging Printout
	print("Start Button Pressed")	
	game_window.visible = !game_window.visible
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()

# --------------- Game Window Functions --------- #

func _on_sys_minimize_button_pressed() -> void:
	sys_body.visible = not sys_body.visible

func _on_inv_minimize_button_pressed() -> void:
	inv_body.visible = not inv_body.visible
	
func _on_tu_minimize_button_pressed() -> void:
	tnu_body.visible = not tnu_body.visible

func _on_store_minimize_button_pressed() -> void:
	str_body.visible = not str_body.visible
	
func _on_field_minimize_button_pressed() -> void:
	fld_body.visible = not fld_body.visible
	
