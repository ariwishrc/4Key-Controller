extends Control

func _on_back_button_down() -> void:
	get_tree().change_scene_to_file("res://Controller/controller.tscn")

func _on_rich_text_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
