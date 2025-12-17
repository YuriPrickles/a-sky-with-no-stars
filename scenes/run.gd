class_name Run
extends Node

var grid:Gridspace
var build_selector:BuildSelector
var energy:int = 0
var metal:int = 0
var water:int = 0
var food:int = 0
var max_energy:int = 15
var max_metal:int = 15
var max_water:int = 15
var max_food:int = 15

@export var buildings_unlocked:Array[BaseRoom]
@onready var canvas_layer = $CanvasLayer

var freezecam:bool = false
var build_mode:bool = false
var building_to_build:Room

func _ready() -> void:
	grid = preload("res://scenes/grid.tscn").instantiate()
	add_child(grid)
	build_selector = preload("res://scenes/build_selector.tscn").instantiate()
	canvas_layer.add_child(build_selector)
	for b in buildings_unlocked:
		build_selector.add_building(b)
	State.loaded_game = self

func _process(delta: float) -> void:
	grid.camera.movable = not freezecam
