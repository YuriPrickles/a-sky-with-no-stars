class_name BuildPopup
extends Control

var room_info:BaseRoom
@onready var title = $ColorRect/MarginContainer/VBoxContainer/TitleLabel
@onready var desc = $ColorRect/MarginContainer/VBoxContainer/HBoxContainer/DescLabel
@onready var buildbutton = $ColorRect/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Button

func _ready() -> void:
	title.text = "[font_size=32]%s" % room_info.room_name
	desc.text = "[font_size=16]%s" % room_info.room_desc


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("cancel_build"):
		State.loaded_game.freezecam = false
		queue_free()

func _process(_delta: float) -> void:
	var no_button = false
	for cost in room_info.build_cost.keys():
		if room_info.build_cost.get(cost) == 0 or room_info.build_cost.get(cost) == null: continue
		if State.loaded_game.resource_dict[cost] < room_info.build_cost.get(cost):
			no_button = true
	buildbutton.disabled = no_button

func _on_button_pressed() -> void:
	State.loaded_game.freezecam = false
	State.loaded_game.build_mode = true
	var room:Room = load("res://scenes/room.tscn").instantiate()
	room.placing = true
	room.room_data = room_info
	State.loaded_game.building_to_build = room
	State.loaded_game.grid.rooms.add_child(room)
	queue_free()
