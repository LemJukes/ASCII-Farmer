extends PanelContainer

# Defines the "Inventory Currency Variables" Label Elements
@onready var seeds_value = get_node("/root/Primary/Main Window/MarginContainer/HBoxContainer/Menues/Inventory/CurrencyValues/SeedValue")
@onready var crops_value = get_node("/root/Primary/Main Window/MarginContainer/HBoxContainer/Menues/Inventory/CurrencyValues/CropValue")

func _ready() -> void:
	print("plot added")
	pass

func _on_state_1_pressed() -> void:
	print(str(VariableStorage.seeds))
	if VariableStorage.seeds >= 1:
		VariableStorage.seeds -= 1
		seeds_value.text = str(VariableStorage.seeds)
		var state1 = $state1
		state1.visible = false
		var state2 = $state2
		state2.visible = true
	else:
		print("Not enough seeds!")
		pass


func _on_state_2_pressed() -> void:
	VariableStorage.crops += 1
	crops_value.text = str(VariableStorage.crops)	
	var state2 = $state2
	state2.visible = false
	var state1 = $state1
	state1.visible = true
	pass # Replace with function body.
