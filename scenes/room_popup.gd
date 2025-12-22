class_name RoomPopup
extends Control

var room:Room
var room_info:BaseRoom
@onready var title = $ColorRect/MarginContainer/VBoxContainer/TitleLabel
@onready var desc = $ColorRect/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/DescLabel
@onready var pioneer_tabs = $ColorRect/MarginContainer/VBoxContainer/HBoxContainer/RightScreen/PioneerTabs

var alphabet_string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

func refresh_info_newroom():
	State.loaded_game.freezecam = true
	State.loaded_game.no_mouse_interact = true
	for tab in pioneer_tabs.get_children():
		tab.queue_free()
	room_info = room.room_data
	State.loaded_game.selected_room = room
	title.text = "[font_size=32]%s" % room_info.room_name
	desc.text = "[font_size=16]%s" % room_info.room_desc
	for i in range(room_info.max_worker_count):
		print(i)
		var pioneer_scr:PioneerScreen = preload("res://scenes/pioneer_screen.tscn").instantiate()
		pioneer_tabs.add_child(pioneer_scr)
		pioneer_tabs.set_tab_title(i,"PIONEER %s" % alphabet_string[i])
		var current_pioneer:BasePioneer = State.loaded_game.assigned_pioneers.get(room)[i]
		pioneer_scr.pioneer_text.text = "[font_size=24]NO ASSIGNED PIONEER." if current_pioneer == null else "[font_size=24]ASSIGNED: %s" % current_pioneer.name
		var stats_text ="[font_size=24]STR --[br]DEX --[br]INT --[br]SAN ---%"
		pioneer_scr.pioneer_pic.texture = preload("res://icon.svg")
		if current_pioneer != null:
			var atlas = AtlasTexture.new()
			pioneer_scr.pioneer_pic.texture = atlas
			atlas.atlas = current_pioneer.portrait
			atlas.region = Rect2(200,160,800,800)
			stats_text ="[font_size=24]STR %s[br]DEX %s[br]INT %s[br]SAN %s%%"%[current_pioneer.strength,current_pioneer.dexterity,current_pioneer.intelligence,current_pioneer.sanity]
		pioneer_scr.stats.text = stats_text

func refresh_info():
	for i in range(room_info.max_worker_count):
		print(i)
		var pioneer_scr:PioneerScreen = pioneer_tabs.get_child(i)
		pioneer_tabs.set_tab_title(i,"PIONEER %s" % alphabet_string[i])
		var current_pioneer:BasePioneer = State.loaded_game.assigned_pioneers.get(room)[i]
		pioneer_scr.pioneer_text.text = "[font_size=24]NO ASSIGNED PIONEER." if current_pioneer == null else "[font_size=24]ASSIGNED: %s" % current_pioneer.name
		if current_pioneer != null:
			pioneer_scr.stats.text = "[font_size=24]STR %s[br]DEX %s[br]INT %s[br]SAN %s%%"%[current_pioneer.strength,current_pioneer.dexterity,current_pioneer.intelligence,current_pioneer.sanity]
			var atlas = AtlasTexture.new()
			pioneer_scr.pioneer_pic.texture = atlas
			atlas.atlas = current_pioneer.portrait
			atlas.region = Rect2(200,160,800,800)

func _process(delta: float) -> void:
	if room_info != null:
		for i in range(room_info.max_worker_count):
			pioneer_tabs.set_tab_title(i,"PIONEER %s" % alphabet_string[i])
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("cancel_build"):
		State.loaded_game.selected_room = null
		State.loaded_game.no_mouse_interact = false
		State.loaded_game.freezecam = false
		hide()

func _on_button_pressed() -> void:
	State.loaded_game.selected_room = null
	State.loaded_game.no_mouse_interact = false
	State.loaded_game.freezecam = false
	hide()
