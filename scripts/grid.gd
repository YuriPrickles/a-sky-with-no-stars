class_name Gridspace
extends Node2D

@export var noise:FastNoiseLite
@onready var camera = $Camera2D
@onready var gridsprites = $GridSprites
@onready var rooms = $Rooms
const water_threshold = 0.3
const grass_threshold = 0.6
var terrain:Dictionary[Vector2,Enums.TerrainType]
var room_map:Dictionary[Vector2,Room]

func _ready() -> void:
	noise.seed = randi()
	for i in range(0,32):
		for j in range(0,32):
			var spr = Sprite2D.new()
			spr.centered = false
			var noise_val = (noise.get_noise_2d(i,j) + .5)
			spr.texture = load("res://icon.svg")
			spr.scale = Vector2(0.5,0.5)
			spr.position = get_pos(i,j)
			var t_type = Enums.TerrainType.Water
			
			if noise_val < water_threshold:
				t_type = Enums.TerrainType.Water
				spr.modulate = Color.BLUE
			elif noise_val < grass_threshold:
				t_type = Enums.TerrainType.Grass
				spr.modulate = Color.LIME_GREEN
			else:
				t_type = Enums.TerrainType.Stonetop
				spr.modulate = Color.DIM_GRAY
			terrain[Vector2(i,j)] = t_type
			gridsprites.add_child(spr)
	camera.position = get_pos(16,16)


func _process(_delta: float) -> void:
	var mx =  floori(get_local_mouse_position().x)
	var my =  floori(get_local_mouse_position().y)
	var current_room:Room = null
	var can_place = false
	if State.loaded_game.building_to_build:
		current_room = State.loaded_game.building_to_build
	if State.loaded_game.build_mode and current_room != null and current_room.placing:
		if current_room.room_data.size_type == Enums.SizeType.Square:
			current_room.position = get_pos_fromvec(get_tile_pos(mx,my,current_room.room_data.square_size))
			var temp_terrains:Array[Enums.TerrainType] = []
			for segment in current_room.room_bits.keys():
				temp_terrains.append(terrain.get(get_tile_pos(mx,my,current_room.room_data.square_size) + segment))
			var type_count = 0
			for t_type in Enums.TerrainType.values():
				if temp_terrains.has(t_type):
					if t_type == int(Enums.TerrainType.Water) or t_type == int(Enums.TerrainType.Building):
						type_count += 999
					type_count += 1
			can_place = type_count < 2
			current_room.placement_color = Color.RED if not can_place else Color.YELLOW
		if Input.is_action_just_pressed("cancel_build"):
			current_room.queue_free()
			State.loaded_game.build_mode = false
			State.loaded_game.building_to_build = null
		if Input.is_action_just_pressed("selection"):
			if can_place:
				for segment in current_room.room_bits.keys():
					terrain[get_tile_pos(mx,my) + segment] = Enums.TerrainType.Building
					room_map[get_tile_pos(mx,my) + segment] = current_room
				current_room.placing = false
				current_room.placement_color = Color.WHITE
				State.loaded_game.building_to_build = null
				State.loaded_game.build_mode = false
				print("Building Placed")
			else:
				print("Invalid Placement")
			print(get_tile_pos(mx,my))
	if not State.loaded_game.build_mode:
		if Input.is_action_just_pressed("selection"):
			print(get_tile_pos(mx,my))
			if room_map.get(get_tile_pos(mx,my)) != null:
				print(room_map.get(get_tile_pos(mx,my)).room_data.room_name)


##Gets the position equivalent from the tile coordinates.
func get_pos_fromvec(pos):
	return pos * 64
##Gets the position equivalent from the tile coordinates.
func get_pos(x,y,furthest_offset:Vector2=Vector2.ONE):
	return Vector2(clamp(x*64,0,(32 - furthest_offset.x)*64), clamp(y*64,0,(32 - furthest_offset.y)*64))

##Gets the tile position equivalent from the position.
func get_tile_pos(x, y,furthest_offset:Vector2=Vector2.ONE):
	return Vector2(clamp((x - x % 64)/64,0,(32 - furthest_offset.x)), clamp((y - y % 64)/64,0,(32 - furthest_offset.y)))
