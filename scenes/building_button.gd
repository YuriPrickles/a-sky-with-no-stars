class_name BuildingButton
extends Button

var room_info:BaseRoom
@onready var building_name = $RichTextLabel
func _ready() -> void:
	building_name.text = "[font_size=24]" + room_info.room_name

func _on_pressed() -> void:
	var buildpopup:BuildPopup = preload("res://scenes/build_popup.tscn").instantiate()
	buildpopup.room_info = room_info
	State.loaded_game.canvas_layer.add_child(buildpopup)
	State.loaded_game.freezecam = true
	pass # Replace with function body.
