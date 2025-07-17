extends VBoxContainer

func _ready():
	_WindowControlSC()
	_UpgradeControlSC()
	pass

# Inventory Window Setup
# Containers
@onready var MainContentPanel: PanelContainer = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer

# Labels


# Buttons
@onready var ToggleViewButton: Button = $Window_PanelContainer/MarginContainer/VBoxContainer/TopBar_HBoxContainer/ToggleViewWindow_Button
@onready var Mk1_CheckButton: CheckButton = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/ExpandedClick_PanelContainer/VBoxContainer/HBoxContainer/Mk1_VBoxContainer/Mk1_CheckButton
@onready var Mk2_CheckButton: CheckButton = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/ExpandedClick_PanelContainer/VBoxContainer/HBoxContainer/Mk2_VBoxContainer/Mk2_CheckButton
@onready var Mk3_CheckButton: CheckButton = $Window_PanelContainer/MarginContainer/VBoxContainer/MainContent_PanelContainer/MarginContainer/VBoxContainer/ExpandedClick_PanelContainer/VBoxContainer/HBoxContainer/Mk3_VBoxContainer/Mk3_CheckButton

# Signal Connectors

func _WindowControlSC() -> void:
	ToggleViewButton.pressed.connect(_on_toggle_view_button_pressed)
	pass

func _UpgradeControlSC() -> void:
	Mk1_CheckButton.toggled.connect(_on_mk1_check_button_toggled)
	Mk2_CheckButton.toggled.connect(_on_mk2_check_button_toggled)
	Mk3_CheckButton.toggled.connect(_on_mk3_check_button_toggled)
	pass

func _on_toggle_view_button_pressed() -> void:
	MainContentPanel.visible = !MainContentPanel.visible
	pass

func _on_mk1_check_button_toggled(button_pressed: bool) -> void:
	if button_pressed:
		print("Mk1 Upgrade selected")
		VarStor.ECmk1 = true
	else:
		print("Mk1 Upgrade deselected")
		VarStor.ECmk1 = false
	pass

func _on_mk2_check_button_toggled(button_pressed: bool) -> void:
	if button_pressed:
		print("Mk2 Upgrade selected")
		VarStor.ECmk2 = true
	else:
		print("Mk2 Upgrade deselected")
		VarStor.ECmk2 = false
	pass

func _on_mk3_check_button_toggled(button_pressed: bool) -> void:
	if button_pressed:
		print("Mk3 Upgrade selected")
		VarStor.ECmk3 = true
	else:
		print("Mk3 Upgrade deselected")
		VarStor.ECmk3 = false
	pass
