extends Control

@onready var ip_line: LineEdit = $VBX/IP/VBX2/ip
@onready var port_line: LineEdit = $VBX/IP/VBX2/port

func _ready() -> void:
	ip_line.text = Globals.get_value("ip")
	port_line.text = str(int(Globals.get_value("port")))

func _on_back_button_down() -> void:
	Globals.change_value("ip", ip_line.text)
	Globals.change_value("port", port_line.text)
	Globals.write_file()
	get_tree().change_scene_to_file("res://Controller/controller.tscn")
