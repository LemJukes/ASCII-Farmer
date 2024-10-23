extends Control

# System Variables
# Player Vars
@onready var player_name = $StartWindow/Background/StartContentStack/PlayerInput/InputWindow/HBoxContainer/VBoxContainer/MarginContainer2/PlayerNameInput
@onready var player_name_display = $GameWindow/Background/GameWindowContentStack/GameSystemContentStack/SystemInfo/HBoxContainer/PlayerNameDisplay

# Game Timer Vars
@onready var game_timer = $GameWindow/Background/GameWindowContentStack/GameSystemContentStack/SystemInfo/HBoxContainer/GameTimer
@onready var game_timer_display = $GameWindow/Background/GameWindowContentStack/GameSystemContentStack/SystemInfo/HBoxContainer/GameTimeDisplay
var elapsed_time: float = 0.0

# UI Variables
# Minimize Button Body Vars
@onready var inv_body = get_node("GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Inventory/Background/VBoxContainer/InvWindowContent")
@onready var tnu_body = get_node("Primary/GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/ToolsAndUpgrades/Background/VBoxContainer/InvTopBar/MarginContainer/HBoxContainer/TopBarButton/TnUMinButton")
@onready var str_body = get_node("Primary/GameWindow/Background/GameWindowContentStack/ScrollContainer/GameContentStack/Store/Background/VBoxContainer/StrTopBar/MarginContainer/HBoxContainer/TopBarButton/StrMinButton")

func _ready() -> void:
	game_timer.wait_time = 0.01
	pass # Replace with function body.

func _process(delta: float) -> void:
	game_timer_display.text = format_time(elapsed_time)
	

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


# Game Content Stack Window Minimize Functions

func _on_inv_min_button_pressed() -> void:
	inv_body.visible = not inv_body.visible

func _on_tn_u_min_button_pressed() -> void:
	tnu_body

func _on_str_min_button_pressed() -> void:
	
