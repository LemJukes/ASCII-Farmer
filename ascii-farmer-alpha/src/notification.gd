extends ColorRect

signal closed() 

@onready var title_label = %NotifTitleLabel
@onready var message_label = %NotifMessageLabel
@onready var close_button = %NotifCloseButton

func _ready():
	close_button.pressed.connect(_on_close_pressed)

func setup(title: String, message: String) -> void:
	if title_label and message_label:
		title_label.text = title
		message_label.text = message
	else:
		print("Error: Labels not found in notification")
	
func _on_close_pressed():
	closed.emit()
	queue_free()
