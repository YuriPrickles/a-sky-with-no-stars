class_name ResourceTracker
extends Control

@onready var energy_text = $MarginContainer/MarginContainer/VBoxContainer/EnergyText
@onready var metal_text = $MarginContainer/MarginContainer/VBoxContainer/MetalText
@onready var water_text = $MarginContainer/MarginContainer/VBoxContainer/WaterText
@onready var food_text = $MarginContainer/MarginContainer/VBoxContainer/FoodText

func set_texts(energy,metal,water,food):
	energy_text.text = "[font_size=16]Energy: %s" % energy
	metal_text.text = "[font_size=16]Metal: %s" % metal
	water_text.text = "[font_size=16]Water: %s" % water
	food_text.text = "[font_size=16]Food: %s" % food


func _on_button_pressed() -> void:
	State.loaded_game.progress_turn()
