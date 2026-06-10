extends LineEdit

var regex = RegEx.new()
var old_text = ""

func _ready() -> void:
	# numbers (0-9) and dots (.)
	regex.compile("^[0-9.]*$")

func _on_text_changed(new_text: String) -> void:
	if regex.search(new_text):
		old_text = new_text
	else:
		var cursor_pos = caret_column
		text = old_text
		caret_column = cursor_pos - 1
