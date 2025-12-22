class_name PioneerCard
extends MarginContainer

@onready var info_text = $ColorRect/MarginContainer/VBoxContainer/InfoLabel
@onready var pioneer_pic = $ColorRect/MarginContainer/VBoxContainer/PioneerPic
@onready var card_color = $ColorRect
var disabled = false
var pioneer_resource:BasePioneer
var ui_offset = 60
var old_offset = 0
var gray_texture:Texture
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pioneer_resource:
		gray_texture = to_grayscale(pioneer_resource.icon)
		disabled = pioneer_resource.occupied
		pioneer_pic.texture = gray_texture if disabled else pioneer_resource.icon
		card_color.color = Color("4a4a4aff") if disabled else Color("572b4b")
	offset_top = move_toward(offset_top, ui_offset, abs(offset_top - ui_offset * 2) * 4 * delta)
	offset_bottom = move_toward(offset_bottom, ui_offset, abs(offset_bottom - ui_offset * 2) * 4 * delta)
	pass
func to_grayscale(texture : Texture2D) -> Texture:
	var image:Image = texture.get_image()
	image.convert(Image.FORMAT_LA8)
	image.convert(Image.FORMAT_RGBA8) # Not strictly necessary

	var image_texture = ImageTexture.new()
	image_texture = ImageTexture.create_from_image(image)
	return image_texture
func set_card_info(pioneer:BasePioneer):
	pioneer_resource = pioneer
	pioneer_pic.texture = pioneer.icon
	var gender = "?"
	match pioneer.gender:
		Enums.PioneerGender.Female: gender = "Female"
		Enums.PioneerGender.Nonbinary: gender = "Non-Binary"
		Enums.PioneerGender.DogFemale: gender = "Dog (Female)"
		Enums.PioneerGender.Male: gender = "Male"
	info_text.text = "[font_size=24][center]%s
%s
[font_size=16]%s
Class: PLACEHOLDER[br]
STR %s DEX %s INT %s" % [pioneer.firstname,pioneer.surname,gender,pioneer.strength,pioneer.dexterity,pioneer.intelligence]


func _on_color_rect_mouse_entered() -> void:
	old_offset = ui_offset
	ui_offset = -40


func _on_color_rect_mouse_exited() -> void:
	old_offset = ui_offset
	ui_offset = 60


func _on_color_rect_gui_input(event: InputEvent) -> void:
	var room = State.loaded_game.selected_room
	var current_tab = State.loaded_game.room_popup.pioneer_tabs.current_tab
	var pioneer_index = State.loaded_game.pioneers.find(pioneer_resource)
	var previous_pioneer:BasePioneer = null
	if State.loaded_game.assigned_pioneers.get(room) != null:
		previous_pioneer = State.loaded_game.assigned_pioneers.get(room)[current_tab]
	if room == null or current_tab <= -1: return
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.is_pressed():
			if State.loaded_game.pioneers[pioneer_index].occupied:
				print("Pioneer Occupied")
				return
			if previous_pioneer != null:
				previous_pioneer.occupied = false
			State.loaded_game.assigned_pioneers.get(room)[current_tab] = pioneer_resource
			State.loaded_game.pioneers[pioneer_index].occupied = true
			State.loaded_game.room_popup.refresh_info()
