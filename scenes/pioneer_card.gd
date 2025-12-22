class_name PioneerCard
extends MarginContainer

@onready var info_text = $ColorRect/MarginContainer/VBoxContainer/InfoLabel

var ui_offset = 120
var old_offset = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	offset_top = move_toward(offset_top, ui_offset, abs(offset_top - ui_offset * 2) * 4 * delta)
	offset_bottom = move_toward(offset_bottom, ui_offset, abs(offset_bottom - ui_offset * 2) * 4 * delta)
	pass

func set_card_info(pioneer:BasePioneer):
	var gender = "?"
	match pioneer.gender:
		Enums.PioneerGender.Female: gender = "Female"
		Enums.PioneerGender.Nonbinary: gender = "Non-Binary"
		Enums.PioneerGender.DogFemale: gender = "Dog (Female)"
		Enums.PioneerGender.Male: gender = "Male"
	info_text.text = "[center]%s
Lastname
[font_size=12]%s
Class: PLACEHOLDER
STR %s DEX %s INT %s" % [pioneer.name,gender,pioneer.strength,pioneer.dexterity,pioneer.intelligence]


func _on_color_rect_mouse_entered() -> void:
	old_offset = ui_offset
	ui_offset = -40


func _on_color_rect_mouse_exited() -> void:
	old_offset = ui_offset
	ui_offset = 120
