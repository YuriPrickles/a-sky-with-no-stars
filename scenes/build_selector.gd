class_name BuildSelector
extends Control

@onready var BuildingContainer = $Margin/Scroll/BuildingContainer

func _ready() -> void:
	pass # Replace with function body.


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("build_menu"):
		visible = not visible

func add_building(room:BaseRoom):
	var buildbutton:BuildingButton = preload("res://scenes/building_button.tscn").instantiate()
	buildbutton.room_info = room
	BuildingContainer.add_child(buildbutton)
	
