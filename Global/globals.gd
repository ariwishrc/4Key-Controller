extends Node

const save_path = "user://4Key.json"

var data: Dictionary = {
	"ip":"127.0.0.1",
	"port":8000,
	"hitbox":[100, 100],
	"left":[0, 85],
	"down":[300, 85],
	"up":[600, 85],
	"right":[900, 85],
}

var default_arrows_pos: Dictionary = {
	"left": Vector2(0, 85),
	"down": Vector2(300, 85),
	"up": Vector2(600, 85),
	"right": Vector2(900, 85)
}

func _ready() -> void:
	load_file()
	
func change_value(key, value) -> void:
	data[key] = value
		
func get_value(key):
	if data.has(key):
		return data[key]
	else:
		printerr(str(key) ,"is Invalid")
		
func write_file() -> void:
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if save_file:
		var data_json = JSON.stringify(data)
		save_file.store_string(data_json)
		save_file.close()
	
func load_file():
	var save_file = FileAccess.open(save_path, FileAccess.READ)
	if save_file:
		var data_text = save_file.get_as_text()
		save_file.close()
		if JSON.parse_string(data_text) != null:
			var temp_data = JSON.parse_string(data_text)
			for i in data:
				if !temp_data.has(i):
					write_file()
					break
			data = temp_data
		else:
			write_file()
