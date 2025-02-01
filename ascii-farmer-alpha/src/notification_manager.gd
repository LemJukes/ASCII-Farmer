extends Node

# Scene reference
const NotificationScene = preload("res://src/notification.tscn")

# Show a notification with given title and message
func show_notification(title: String, message: String) -> void:
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
    
    # Cleanup when closed
    notif.closed.connect(
        func(): canvas.queue_free(),
        CONNECT_ONE_SHOT
    )