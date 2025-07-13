extends Control

func _ready() -> void:
	_MainMenuSC()
	_GameContainerINIT()
	pass

# Main Menu Bar Setup
# Containers
@onready var MainMenu_PanelContainer: PanelContainer = $MainMenu_PanelContainer

# Buttons
@onready var MainMenu_Button: Button = $TopMenu_PanelContainer/MarginContainer/HBoxContainer/MainMenu_Button
@onready var NewGame_Button: Button = $MainMenu_PanelContainer/MarginContainer/VBoxContainer/NewGame_Button
@onready var SaveGame_Button: Button = $MainMenu_PanelContainer/MarginContainer/VBoxContainer/SaveGame_Button
@onready var LoadGame_Button: Button = $MainMenu_PanelContainer/MarginContainer/VBoxContainer/LoadGame_Button
@onready var Help_Button: Button = $MainMenu_PanelContainer/MarginContainer/VBoxContainer/Help_Button
@onready var Settings_Button: Button = $MainMenu_PanelContainer/MarginContainer/VBoxContainer/Settings_Button
@onready var Exit_Button: Button = $MainMenu_PanelContainer/MarginContainer/VBoxContainer/Exit_Button

# Signal Connectors
func _MainMenuSC() -> void:
	# Connect signals for the main menu button
	MainMenu_Button.pressed.connect(_on_main_menu_button_pressed)
	
	# Connect signals for the menu buttons
	NewGame_Button.pressed.connect(_on_new_game_button_pressed)
	SaveGame_Button.pressed.connect(_on_save_game_button_pressed)
	LoadGame_Button.pressed.connect(_on_load_game_button_pressed)
	Help_Button.pressed.connect(_on_help_button_pressed)
	Settings_Button.pressed.connect(_on_settings_button_pressed)
	Exit_Button.pressed.connect(_on_exit_button_pressed)

# Panel Control Function
func _on_main_menu_button_pressed() -> void:
	MainMenu_PanelContainer.visible = !MainMenu_PanelContainer.visible
	pass

# Button Functions
func _on_new_game_button_pressed() -> void:
	print("New Game Button Pressed")
	# Logic to start a new game goes here
	pass

func _on_save_game_button_pressed() -> void:
	print("Save Game Button Pressed")
	# Logic to save the current game goes here
	pass

func _on_load_game_button_pressed() -> void:
	print("Load Game Button Pressed")
	# Logic to load a saved game goes here
	pass

func _on_help_button_pressed() -> void:
	print("Help Button Pressed")
	# Logic to show help information goes here
	pass

func _on_settings_button_pressed() -> void:
	print("Settings Button Pressed")
	# Logic to open settings menu goes here
	pass

func _on_exit_button_pressed() -> void:
	print("Exit Button Pressed")
	# Logic to exit the game goes here
	get_tree().quit()  # This will close the game
	pass

# Game Window Instantiation
@onready var GameContainer: VBoxContainer = $GameWindow_ScrollContainer/MarginContainer/VBoxContainer

# Window Scene Preloaders
@onready var InventoryWindow: PackedScene = preload("res://src/scenes/windows/inventory_window.tscn")
@onready var ToolsWindow: PackedScene = preload("res://src/scenes/windows/tools_window.tscn")

# Instantiation Function
func _GameContainerINIT() -> void:
	var inventory_window_instance = InventoryWindow.instantiate()
	GameContainer.add_child(inventory_window_instance)

	var tools_window_instance = ToolsWindow.instantiate()
	GameContainer.add_child(tools_window_instance)
