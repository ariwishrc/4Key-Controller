extends LineEdit

var regex = RegEx.new()
var old_text = ""

func _ready() -> void:
	# "^\d*$" matches any string containing only digits
	regex.compile("^\\d*$")

func _on_text_changed(new_text: String) -> void:
	if regex.search(new_text):
		# Ensure the number is within valid port range
		if new_text == "" or (new_text.to_int() >= 0 and new_text.to_int() <= 65535):
			old_text = new_text
			return
	
	# Revert if not a number or out of range
	var cursor_pos = caret_column
	text = old_text
	caret_column = cursor_pos - 1
