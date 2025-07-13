extends Container

func _ready() -> void:
	_WindowControlSC()
	_ToolControlSC()
	pass

# Inventory Window Setup
# Containers
@onready var MainContentPanel: PanelContainer = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer

# Labels
@onready var CurrentToolValueLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/CurrentToolValue_Label

# Buttons
@onready var ToggleViewButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/TopBar_HBoxContainer/ToggleView_Button

@onready var ToolHoeButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ToolHoe_Button
@onready var ToolSeedBagButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ToolSeedBag_Button
@onready var ToolWateringCanButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ToolWateringCan_Button
@onready var ToolSickleButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ToolSickle_Button

# Signal Connectors
func _WindowControlSC() -> void:
	ToggleViewButton.pressed.connect(_on_toggle_view_button_pressed)

func _ToolControlSC() -> void:
	ToolHoeButton.pressed.connect(_on_tool_hoe_button_pressed)
	ToolSeedBagButton.pressed.connect(_on_tool_seed_bag_button_pressed)
	ToolWateringCanButton.pressed.connect(_on_tool_watering_can_button_pressed)
	ToolSickleButton.pressed.connect(_on_tool_sickle_button_pressed)


# Functions
func _on_toggle_view_button_pressed() -> void:
	MainContentPanel.visible = !MainContentPanel.visible
	pass

func _on_tool_hoe_button_pressed() -> void:
	CurrentToolValueLabel.text = VarStor.TOOL_HOE
	print("Tool selected: " + VarStor.TOOL_HOE)
	pass

func _on_tool_seed_bag_button_pressed() -> void:
	CurrentToolValueLabel.text = VarStor.TOOL_SEED_BAG
	print("Tool selected: " + VarStor.TOOL_SEED_BAG)
	pass

func _on_tool_watering_can_button_pressed() -> void:
	CurrentToolValueLabel.text = VarStor.TOOL_WATERING_CAN
	print("Tool selected: " + VarStor.TOOL_WATERING_CAN)
	pass

func _on_tool_sickle_button_pressed() -> void:
	CurrentToolValueLabel.text = VarStor.TOOL_SICKLE
	print("Tool selected: " + VarStor.TOOL_SICKLE)
	pass