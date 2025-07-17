extends VBoxContainer

func _ready():
	_WindowControlSC()
	_StoreButtonSC()
	_store_value_display_Init()
	pass

# Inventory Window Setup
# Containers
@onready var MainContentPanel: PanelContainer = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer
@onready var SuppliesVBoxContainer: VBoxContainer = %Supplies_VBoxContainer

# Labels
@onready var yenSeedsCostLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies1_HBoxContainer/yenSeeds_VBoxContainer/HBoxContainer2/yenSeedsCost_Label
@onready var poundSeedsCostLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies1_HBoxContainer/poundSeeds_VBoxContainer/HBoxContainer2/poundSeedsCost_Label
@onready var euroSeedCostLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies1_HBoxContainer/euroSeeds_VBoxContainer/HBoxContainer2/euroSeedsCost_Label
@onready var FertilizerCostLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies2_HBoxContainer/Fertilizer_VBoxContainer/FertilizerPrice_HBoxContainer/FertilizerCost_Label
@onready var WaterCostLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies2_HBoxContainer/Water_VBoxContainer/WaterCost_HBoxContainer/WaterCost_Label

# Buttons
@onready var ToggleViewButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/TopBar_HBoxContainer/ToggleViewWindow_Button
@onready var SuppliesViewButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/HBoxContainer/SuppliesViewButton

@onready var yenSeeds1xBuyButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies1_HBoxContainer/yenSeeds_VBoxContainer/HBoxContainer/Seeds1x_Button
@onready var yenSeeds3xBuyButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies1_HBoxContainer/yenSeeds_VBoxContainer/HBoxContainer/Seeds3x_Button
@onready var yenSeeds9xBuyButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies1_HBoxContainer/yenSeeds_VBoxContainer/HBoxContainer/Seeds9x_Button

@onready var poundSeeds1xBuyButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies1_HBoxContainer/poundSeeds_VBoxContainer/HBoxContainer/Seeds1x_Button
@onready var poundSeeds3xBuyButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies1_HBoxContainer/poundSeeds_VBoxContainer/HBoxContainer/Seeds3x_Button
@onready var poundSeeds9xBuyButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies1_HBoxContainer/poundSeeds_VBoxContainer/HBoxContainer/Seeds9x_Button

@onready var euroSeeds1xBuyButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies1_HBoxContainer/euroSeeds_VBoxContainer/HBoxContainer/Seeds1x_Button
@onready var euroSeeds3xBuyButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies1_HBoxContainer/euroSeeds_VBoxContainer/HBoxContainer/Seeds3x_Button
@onready var euroSeeds9xBuyButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Supplies_PanelContainer/VBoxContainer/Supplies_VBoxContainer/Supplies1_HBoxContainer/euroSeeds_VBoxContainer/HBoxContainer/Seeds9x_Button

# Signal Connectors

func _WindowControlSC() -> void:
	ToggleViewButton.pressed.connect(_on_toggle_view_button_pressed)
	SuppliesViewButton.pressed.connect(_on_supplies_view_button_pressed)
	pass

func _on_toggle_view_button_pressed() -> void:
	MainContentPanel.visible = !MainContentPanel.visible
	pass

func _on_supplies_view_button_pressed() -> void:
	SuppliesVBoxContainer.visible = !SuppliesVBoxContainer.visible
	pass

func _StoreButtonSC() -> void:
	# Connect the store button signals to their respective functions
	# This is where you would connect buttons for buying seeds, fertilizer, and water
	pass

func _store_value_display_Init() -> void:
	# Display the store values
	yenSeedsCostLabel.text = str(VarStor.yenSeedCost)
	poundSeedsCostLabel.text = str(VarStor.poundSeedCost)
	euroSeedCostLabel.text = str(VarStor.euroSeedCost)
	FertilizerCostLabel.text = str(VarStor.FertCost)
	WaterCostLabel.text = str(VarStor.WaterCost)
	pass