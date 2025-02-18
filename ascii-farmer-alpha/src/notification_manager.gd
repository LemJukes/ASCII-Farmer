extends Node

const NotificationScene = preload("res://src/notification.tscn")

# Track active notifications by their title+message combination
var active_notifications = {}
var notification_stack = []  # Add this to track notification order

func show_notification(title: String, message: String) -> void:
    # Create a unique key for this notification
    var notification_key = title + "|" + message
    
    # Check if this exact notification is already showing
    if active_notifications.has(notification_key):
        return
    
    # Instance the notification
    var notif = NotificationScene.instantiate()
    
    # Create canvas layer
    var canvas = CanvasLayer.new()
    canvas.layer = 100
    
    # Add to tree
    add_child(canvas)
    canvas.add_child(notif)
    
    # Setup notification
    notif.setup(title, message)
    
    # Store reference to active notification
    active_notifications[notification_key] = notif
    notification_stack.push_back(notif)  # Add to stack
    
    # Reposition all notifications
    _reposition_notifications()
    
    # Cleanup when closed
    notif.closed.connect(
        func():
            active_notifications.erase(notification_key)
            notification_stack.erase(notif)  # Remove from stack
            _reposition_notifications()  # Reposition remaining notifications
            canvas.queue_free()
    )

func _reposition_notifications() -> void:
    var vertical_offset = 0
    for notif in notification_stack:
        # Center horizontally and stack from top
        notif.position.x = (get_viewport().get_visible_rect().size.x - notif.size.x) / 2
        notif.position.y = 50 + vertical_offset  # Start 50 pixels from top
        vertical_offset += notif.size.y + 10  # Add spacing between notifications