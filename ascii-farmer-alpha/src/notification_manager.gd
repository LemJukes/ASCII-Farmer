extends Node

var notification_scene = preload("res://src/notification_popup.tscn")
var current_notification = null

func show_notification(text: String):
    if current_notification != null:
        current_notification.queue_free()
    
    current_notification = notification_scene.instantiate()
    get_tree().root.add_child(current_notification)
    current_notification.show_message(text)