extends PopupPanel

@onready var label = $MarginContainer/Label
var display_time = 2.0  # Time in seconds to show notification

func _ready():
    hide()

func show_message(text: String):
    label.text = text
    popup_centered()  # Show centered on screen
    get_tree().create_timer(display_time).timeout.connect(hide)