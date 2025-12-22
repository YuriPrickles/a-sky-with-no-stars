class_name RoomPopup
extends Control

var room_info:BaseRoom
@onready var title = $ColorRect/MarginContainer/VBoxContainer/TitleLabel
@onready var desc = $ColorRect/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/DescLabel

func _ready() -> void:
	title.text = "[font_size=32]%s" % room_info.room_name
	desc.text = "[font_size=16]%s" % room_info.room_desc
	State.loaded_game.freezecam = true
	State.loaded_game.no_mouse_interact = true


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("cancel_build"):
		State.loaded_game.no_mouse_interact = false
		State.loaded_game.freezecam = false
		queue_free()

func _on_button_pressed() -> void:
	State.loaded_game.no_mouse_interact = false
	State.loaded_game.freezecam = false
	queue_free()
