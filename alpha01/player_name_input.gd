extends LineEdit

func _ready() -> void:
	grab_focus()

func _on_text_changed(player_name: String) -> void:
	vs.player_name = player_name
