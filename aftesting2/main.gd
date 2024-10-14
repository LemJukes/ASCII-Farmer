extends Control

@onready var sys_body = get_node("ScrollContainer/Primary-VBoxContainer/System-VBoxContainer")
@onready var inv_body = get_node("ScrollContainer/Primary-VBoxContainer/Inventory-VBoxContainer")
@onready var tnu_body = get_node("ScrollContainer/Primary-VBoxContainer/Tools&Upgrades-VBoxContainer")
@onready var str_body = get_node("ScrollContainer/Primary-VBoxContainer/Store-VBoxContainer")
@onready var fld_body = get_node("ScrollContainer/Primary-VBoxContainer/Field-VBoxContainer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# -------------- Start Window Fucntions --------- #

func _on_start_button_pressed() -> void:
	print("Start Button Pressed")
	
	pass # Replace with function body.

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
	
