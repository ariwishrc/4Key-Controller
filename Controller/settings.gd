extends Button


func _on_button_down() -> void:
	get_tree().call_deferred("change_scene_to_file","res://Settings/settings.tscn")
