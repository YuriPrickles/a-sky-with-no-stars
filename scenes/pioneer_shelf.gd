class_name PioneerShelf
extends Control

var ui_offset = 160
var old_offset = 0

var interactable:bool = true

func _ready() -> void:
	offset_bottom = 160


func _process(delta: float) -> void:
	offset_bottom = move_toward(offset_bottom, ui_offset, abs(offset_bottom - ui_offset) * 10 * delta)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_pioneer_shelf"):
		old_offset = ui_offset
		ui_offset = 160 if ui_offset != 160 else 0
