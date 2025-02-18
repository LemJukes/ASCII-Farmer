extends ColorRect

signal closed() 

@onready var title_label = %NotifTitleLabel
@onready var message_label = %NotifMessageLabel
@onready var close_button = %NotifCloseButton

func _ready():
    add_to_group("notifications")
    close_button.pressed.connect(_on_close_pressed)
    custom_minimum_size.y = 0  

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):  
        var notifications = get_tree().get_nodes_in_group("notifications")
        if notifications.size() > 0 and notifications.back() == self:
            get_viewport().set_input_as_handled()
            _on_close_pressed()

func setup(title: String, message: String) -> void:
    if title_label and message_label:
        title_label.text = title
        message_label.text = message

        # Wait for layout to update
        await get_tree().process_frame

        # Resize notification based on content
        var required_height = $VBoxContainer.get_minimum_size().y
        custom_minimum_size.y = required_height
        size.y = required_height
        
        # Initial position (will be adjusted by NotificationManager)
        position.x = (get_viewport_rect().size.x - size.x) / 2
        position.y = 50
    else:
        print("Error: Labels not found in notification")

func _on_close_pressed():
    closed.emit()
    queue_free()