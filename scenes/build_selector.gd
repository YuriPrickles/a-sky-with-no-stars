class_name BuildSelector
extends Control

@onready var BuildingContainer = $Margin/Scroll/BuildingContainer

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_building(room:BaseRoom):
	var buildbutton:BuildingButton = preload("res://scenes/building_button.tscn").instantiate()
	buildbutton.room_info = room
	BuildingContainer.add_child(buildbutton)
	
