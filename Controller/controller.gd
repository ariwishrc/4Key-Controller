extends Node

@onready var settings := $Control/VBX/HBX/settings
@onready var about := $Control/VBX/HBX/about
@onready var width_slider := $Control/VBX/HBX/VBX/slider
@onready var height_slider := $Control/VBX/HBX/VBX2/slider
@onready var edit_ui: Array[Node] = [
	$Control/VBX/HBX/width, $Control/VBX/HBX/VBX,
	$Control/VBX/HBX/height, $Control/VBX/HBX/VBX2, $Control/VBX/HBX/reset
]

var button_offset := Vector2i(80, 80)
var screen_size: Vector2
var hitbox: Vector2i
var hitbox_size: Vector2
var udp = PacketPeerUDP.new()
var connected := false
var edit_mode := false
var edit_held_arrow: String

var active: Dictionary # finger index: arrow name
var arrows: Dictionary # arrow name: Vector2 position
var arrow_textures: Dictionary



func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size

	var saved_hitbox = Globals.get_value("hitbox")
	hitbox = Vector2i(saved_hitbox[0], saved_hitbox[1])
	width_slider.value = hitbox.x
	height_slider.value = hitbox.y
	_recalc_hitbox_size()

	var ip_address: String = Globals.get_value("ip")
	var port: int = int(Globals.get_value("port"))
	if ip_address.is_valid_ip_address():
		udp.connect_to_host(ip_address, port)
		print("Connected to IP: " + ip_address + " Port: " + str(port))
		connected = true

	for arrow in Globals.default_arrows_pos:
		arrow_textures[arrow] = {
			"0":load("res://Assets/Arrows/"+arrow+"_.png"),
			"1":load("res://Assets/Arrows/"+arrow+".png")
		}
		
		var saved_pos = Globals.get_value(arrow)
		arrows[arrow] = Vector2(saved_pos[0], saved_pos[1])
		_update_arrow_node(arrow)
		var hb = get_node(arrow + "/hb")
		hb.size = hitbox_size
		hb.visible = false

	for i in range(10):
		active[str(i)] = ""

	settings.visible = true
	about.visible = true
	for obj in edit_ui:
		obj.visible = false

func _input(event: InputEvent) -> void:
	if !edit_mode:
		if event is InputEventScreenTouch:
			if event.pressed:
				_update_state(event.index, _arrow_at(event.position))
			else:
				_update_state(event.index, "")
		elif event is InputEventScreenDrag:
			_update_state(event.index, _arrow_at(event.position))

	else:
		if event is InputEventScreenTouch:
			if event.pressed:
				edit_held_arrow = _arrow_at(event.position)
			else:
				edit_held_arrow = ""
		elif event is InputEventScreenDrag and edit_held_arrow != "":
			var arrow_node = get_node_or_null(edit_held_arrow)
			arrow_node.position.x = clamp(event.position.x - (hitbox_size.x / 2), 0, screen_size.x - hitbox_size.x)
			arrow_node.position.y = clamp(event.position.y - (hitbox_size.y / 2), 85, screen_size.y - hitbox_size.y + 85)
			arrows[edit_held_arrow] = arrow_node.position

func _arrow_at(pos: Vector2) -> String:
	for arrow in arrows:
		if Rect2(arrows[arrow], hitbox_size).has_point(pos):
			return arrow
	return ""

func _update_state(index: int, new_arrow: String) -> void:
	var old_arrow = active[str(index)]
	if old_arrow == new_arrow: return
	if old_arrow != "": 
		_send_udp(old_arrow + "0")
		print(old_arrow + "_off")
		get_node(old_arrow).texture = arrow_textures[old_arrow]["0"]
	if new_arrow != "":
		_send_udp(new_arrow + "1")
		print(new_arrow + "_on")
		get_node(new_arrow).texture = arrow_textures[new_arrow]["1"]
	active[str(index)] = new_arrow
	

func _recalc_hitbox_size() -> void:
	hitbox_size = Vector2(((screen_size.x / 4) / 100) * hitbox.x, (screen_size.y / 100) * hitbox.y)

func _update_arrow_node(arrow: String) -> void:
	var node = get_node(arrow)
	node.position = arrows[arrow]
	node.offset.x = (hitbox_size.x / 2) - button_offset.x
	node.offset.y = (hitbox_size.y / 2) - button_offset.y
	

func _on_edit_toggled(toggled_on: bool) -> void:
	edit_mode = toggled_on
	edit_held_arrow = ""
	settings.visible = !toggled_on
	about.visible = !toggled_on
	for obj in edit_ui:
		obj.visible = toggled_on
	for arrow in arrows:
		get_node(arrow + "/hb").visible = toggled_on
	if !toggled_on:
		Globals.change_value("hitbox", [hitbox.x, hitbox.y])
		for arrow in arrows:
			Globals.change_value(arrow, [arrows[arrow].x, arrows[arrow].y])
		Globals.write_file()

func _send_udp(packet: String) -> void:
	if connected:
		udp.put_packet(packet.to_utf8_buffer())

func _on_width_value_changed(value: int) -> void:
	hitbox.x = value
	_recalc_hitbox_size()
	for arrow in arrows:
		get_node(arrow + "/hb").size.x = hitbox_size.x
		get_node(arrow).offset.x = (hitbox_size.x / 2) - button_offset.x

func _on_height_value_changed(value: int) -> void:
	hitbox.y = value
	_recalc_hitbox_size()
	for arrow in arrows:
		get_node(arrow + "/hb").size.y = hitbox_size.y
		get_node(arrow).offset.y = (hitbox_size.y / 2) - button_offset.y

func _on_reset_button_down() -> void:
	for arrow in arrows:
		arrows[arrow] = Globals.default_arrows_pos[arrow]
		_update_arrow_node(arrow)
