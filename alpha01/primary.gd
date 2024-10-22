extends Control

# IDK man your brain is not great at this yet 
@onready var player_name = $StartWindow/Background/StartContentStack/PlayerInput/InputWindow/HBoxContainer/VBoxContainer/MarginContainer2/PlayerNameInput
@onready var player_name_display = $GameWindow/Background/GameWindowContentStack/GameSystemContentStack/SystemInfo/HBoxContainer/PlayerNameDisplay

@onready var game_timer = $GameWindow/Background/GameWindowContentStack/GameSystemContentStack/SystemInfo/HBoxContainer/GameTimer
@onready var game_timer_display = $GameWindow/Background/GameWindowContentStack/ameSystemContentStack/SystemInfo/HBoxContainer/GameTimeDisplay

var elapsed_time: float = 0.0


func _ready() -> void:
	game_timer.wait_time = 1.0
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
	elapsed_time += 1.0
	
func format_time(seconds: float) -> String:
	var hours = int(seconds) / 3600
	var minutes = (int(seconds) % 3600) / 60
	var secs = int(seconds) % 60
	
	var hours_str = str(hours).pad_zeros(2)
	var minutes_str = str(minutes).pad_zeros(2)
	var secs_str = str(secs).pad_zeros(2)
	
	return hours_str + ":" + minutes_str + ":" + secs_str
