extends Container

func _ready() -> void:
	_WindowControlSC()
	_SpeciesOptionsSC()
	_inventoryDI()
	pass

# Containers
@onready var MainContentPanel: PanelContainer = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer

# Buttons
@onready var ToggleViewButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/TopBar_HBoxContainer/ToggleView_Button
@onready var SpeciesOptionButton: OptionButton = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/Species_HBoxContainer/Species_OptionButton

# Type Labels
@onready var SeedTypeLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Seeds_VBoxContainer/HBoxContainer/SeedType_Label
@onready var CropTypeLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Crops_VBoxContainer/HBoxContainer/CropType_Label

# Value Labels
@onready var CoinsValueLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Coins_VBoxContainer/CoinsValue_Label
@onready var FertilizerValueLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Fertilizer_VBoxContainer/FertilizerValue_Label
@onready var SeedsValueLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Seeds_VBoxContainer/SeedsValue_Label
@onready var CropsValueLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Crops_VBoxContainer/CropsValue_Label
@onready var WaterValueLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Water_VBoxContainer/WaterValue_Label
@onready var WaterCapValueLabel: Label = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/WaterCap_VBoxContainer/WaterCapValue_Label

# Signal Connectors
func _WindowControlSC() -> void:
	ToggleViewButton.pressed.connect(_on_toggle_view_button_pressed)

func _SpeciesOptionsSC() -> void:
	SpeciesOptionButton.item_selected.connect(_on_species_option_selected)

# Display Initializer
func _inventoryDI() -> void:
	CoinsValueLabel.text = str(VarStor.coins)
	FertilizerValueLabel.text = str(VarStor.fertilizer)
	WaterValueLabel.text = str(VarStor.water)
	WaterCapValueLabel.text = str(VarStor.waterCap)

func _on_toggle_view_button_pressed() -> void:
	MainContentPanel.visible = !MainContentPanel.visible
	pass

func _on_species_option_selected(index: int) -> void:
	match index:
		0:
			SeedTypeLabel.text = "¥"
			SeedsValueLabel.text = str(VarStor.yenSeeds)
			CropTypeLabel.text = "¥"
			CropsValueLabel.text = str(VarStor.yenCrops)
		1:
			SeedTypeLabel.text = "₤"
			SeedsValueLabel.text = str(VarStor.poundSeeds)
			CropTypeLabel.text = "₤"
			CropsValueLabel.text = str(VarStor.poundCrops)
		2:
			SeedTypeLabel.text = "€"
			SeedsValueLabel.text = str(VarStor.euroSeeds)
			CropTypeLabel.text = "€"
			CropsValueLabel.text = str(VarStor.euroCrops)
