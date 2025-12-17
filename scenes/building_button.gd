class_name BuildingButton
extends Button

var room_info:BaseRoom

func _ready() -> void:
	text = room_info.room_name

func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	print("j")
	var buildpopup:BuildPopup = preload("res://scenes/build_popup.tscn").instantiate()
	buildpopup.room_info = room_info
	State.loaded_game.canvas_layer.add_child(buildpopup)
	State.loaded_game.freezecam = true
	pass # Replace with function body.
