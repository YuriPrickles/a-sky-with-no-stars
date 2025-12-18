class_name BuildPopup
extends Control

var room_info:BaseRoom
@onready var title = $ColorRect/MarginContainer/VBoxContainer/TitleLabel
@onready var desc = $ColorRect/MarginContainer/VBoxContainer/HBoxContainer/DescLabel

func _ready() -> void:
	title.text = "[font_size=32]%s" % room_info.room_name
	desc.text = "[font_size=16]%s" % room_info.room_desc


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("cancel_build"):
		State.loaded_game.freezecam = false
		queue_free()

func _on_button_pressed() -> void:
	State.loaded_game.freezecam = false
	State.loaded_game.build_mode = true
	var room:Room = load("res://scenes/room.tscn").instantiate()
	room.placing = true
	room.room_data = room_info
	State.loaded_game.building_to_build = room
	State.loaded_game.grid.rooms.add_child(room)
	queue_free()
