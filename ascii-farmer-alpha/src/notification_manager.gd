extends Node

const NotificationScene = preload("res://src/notification.tscn")

# Track active notifications by their title+message combination
var active_notifications = {}

# Show a notification with given title and message
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
	
	# Cleanup when closed
	notif.closed.connect(
		func():
			active_notifications.erase(notification_key)
			canvas.queue_free(),
		CONNECT_ONE_SHOT
	)
