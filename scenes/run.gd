class_name Run
extends Node

var grid:Gridspace
var build_selector:BuildSelector
var res_tracker:ResourceTracker
var pioneer_shelf:PioneerShelf

var energy:int = 0
var metal:int = 0
var water:int = 0
var food:int = 0
var max_energy:int = 15
var max_metal:int = 15
var max_water:int = 15
var max_food:int = 15

@export var buildings_unlocked:Array[BaseRoom]
@export var pioneers:Array[BasePioneer]
@onready var canvas_layer = $CanvasLayer

var assigned_pioneers:Dictionary[Room,Array]
var selected_room:Room

var no_mouse_interact = false
var freezecam:bool = false
var build_mode:bool = false
var building_to_build:Room
var turn = 0

func _ready() -> void:
	grid = preload("res://scenes/grid.tscn").instantiate()
	add_child(grid)
	build_selector = preload("res://scenes/build_selector.tscn").instantiate()
	canvas_layer.add_child(build_selector)
	res_tracker = preload("res://scenes/resource_tracker.tscn").instantiate()
	canvas_layer.add_child(res_tracker)
	pioneer_shelf = preload("res://scenes/pioneer_shelf.tscn").instantiate()
	canvas_layer.add_child(pioneer_shelf)
	pioneer_shelf.set_pioneer_cards(pioneers)
	for b in buildings_unlocked:
		build_selector.add_building(b)
	State.loaded_game = self

func _process(_delta: float) -> void:
	grid.camera.movable = not freezecam
	res_tracker.set_texts(energy,metal,water,food)

func update_resources(energy_, metal_, water_, food_):
	energy = min(energy + energy_,max_energy)
	metal = min(metal + metal_,max_metal)
	water = min(water + water_,max_water)
	food = min(food + food_,max_food)

func progress_turn():
	if build_mode: return
	turn += 1
	for room:Room in grid.rooms.get_children():
		room.room_data.on_next_turn()
		pass
