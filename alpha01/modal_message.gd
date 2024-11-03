extends Control

@export var default_title: String = "Modal Message"
@export var default_message: String = "Something has gone terribly wrong."

@onready var title_label: Label = %ModalTitleLabel
@onready var text_label: Label = %ModalTextLabel
@onready var close_button: Button = %ModalCloseButton

func _ready():
	# Connect the close button.
	close_button.pressed.connect(_on_close_button_pressed)
	# Initialize with default values
	title_label.text = default_title
	text_label.text = default_message
	# Hide the Modal on Start
	hide()

func show_message(title: String = default_title, message: String = default_message) -> void:
	title_label.text = title
	text_label.text = message
	show()

func _on_close_button_pressed() -> void:
	queue_free()
