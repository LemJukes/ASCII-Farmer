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
@onready var MarketVboxContainer: VBoxContainer = %Market_VBoxContainer
@onready var UpgradesVBoxContainer: VBoxContainer = %Upgrades_VBoxContainer

# Labels
@onready var yenSeedsCostLabel: Label = %yenSeedsCost_Label
@onready var poundSeedsCostLabel: Label = %poundSeedsCost_Label
@onready var euroSeedCostLabel: Label = %euroSeedsCost_Label

@onready var FertilizerCostLabel: Label = %FertilizerCost_Label
@onready var WaterCostLabel: Label = %WaterCost_Label

@onready var yenCropPriceLabel: Label = %yenCropPrice_Label
@onready var poundCropPriceLabel: Label = %poundCropPrice_Label
@onready var euroCropPriceLabel: Label = %euroCropPrice_Label

@onready var UpgradeMkLabel: Label = %UpgradeMk_Label
@onready var UpgradeCostLabel: Label = %UpgradeCost_Label

# Buttons
@onready var StoreWindowViewButton: Button = %StoreWindowView_Button
@onready var SuppliesViewButton: Button = %SuppliesView_Button
@onready var MarketViewButton: Button = %MarketView_Button
@onready var UpgradesViewButton: Button = %UpgradesView_Button

@onready var yenSeeds1xBuyButton: Button = %yenSeeds1x_Button
@onready var yenSeeds3xBuyButton: Button = %yenSeeds3x_Button
@onready var yenSeeds9xBuyButton: Button = %yenSeeds9x_Button

@onready var poundSeeds1xBuyButton: Button = %poundSeeds1x_Button
@onready var poundSeeds3xBuyButton: Button = %poundSeeds3x_Button
@onready var poundSeeds9xBuyButton: Button = %poundSeeds9x_Button

@onready var euroSeeds1xBuyButton: Button = %euroSeeds1x_Button
@onready var euroSeeds3xBuyButton: Button = %euroSeeds3x_Button
@onready var euroSeeds9xBuyButton: Button = %euroSeeds9x_Button

@onready var Fertilizer1xBuyButton: Button = %fert1x_Button
@onready var Fertilizer3xBuyButton: Button = %fert3x_Button
@onready var Fertilizer9xBuyButton: Button = %fert9x_Button

@onready var Water10xBuyButton: Button = %water10x_Button
@onready var Water30xBuyButton: Button = %water30x_Button
@onready var Water90xBuyButton: Button = %water90x_Button

@onready var yenCrop1xButton: Button = %yenCrop1x_Button
@onready var yenCrop3xButton: Button = %yenCrop3x_Button
@onready var yenCrop9xButton: Button = %yenCrop9x_Button

@onready var poundCrop1xButton: Button = %poundCrop1x_Button
@onready var poundCrop3xButton: Button = %poundCrop3x_Button
@onready var poundCrop9xButton: Button = %poundCrop9x_Button

@onready var euroCrop1xButton: Button = %euroCrop1x_Button
@onready var euroCrop3xButton: Button = %euroCrop3x_Button
@onready var euroCrop9xButton: Button = %euroCrop9x_Button

@onready var UpgradeBuyButton: Button = %UpgradeBuy_Button


# Signal Connectors

func _WindowControlSC() -> void:
	StoreWindowViewButton.pressed.connect(_on_toggle_view_button_pressed)
	SuppliesViewButton.pressed.connect(_on_supplies_view_button_pressed)
	MarketViewButton.pressed.connect(_on_market_view_button_pressed)
	UpgradesViewButton.pressed.connect(_on_upgrades_view_button_pressed)
	pass

func _on_toggle_view_button_pressed() -> void:
	MainContentPanel.visible = !MainContentPanel.visible
	pass

func _on_supplies_view_button_pressed() -> void:
	SuppliesVBoxContainer.visible = !SuppliesVBoxContainer.visible
	pass

func _on_market_view_button_pressed() -> void:
	MarketVboxContainer.visible = !MarketVboxContainer.visible
	pass

func _on_upgrades_view_button_pressed() -> void:
	UpgradesVBoxContainer.visible = !UpgradesVBoxContainer.visible
	pass

func _StoreButtonSC() -> void:
	# Connect the store button signals to their respective functions
	pass

func _store_value_display_Init() -> void:
	yenSeedsCostLabel.text = str(VarStor.yenSeedCost)
	poundSeedsCostLabel.text = str(VarStor.poundSeedCost)
	euroSeedCostLabel.text = str(VarStor.euroSeedCost)
	FertilizerCostLabel.text = str(VarStor.FertCost)
	WaterCostLabel.text = str(VarStor.WaterCost)
	UpgradeMkLabel.text = str(VarStor.upgradeMk)
	UpgradeCostLabel.text = str(VarStor.upgradeCost)
	pass
