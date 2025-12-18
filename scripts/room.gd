class_name Room
extends Node2D
@export var room_data:BaseRoom

var room_bits:Dictionary[Vector2,Texture2D]
var placing = true

var placement_color:Color = Color.RED

func _ready() -> void:
	if room_data.size_type == Enums.SizeType.Square:
		for x in range(room_data.square_size.x):
			for y in range(room_data.square_size.y):
				var tex:Texture2D = load("res://icondupe.svg")
				room_bits[Vector2(x,y)] = tex

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	for segment in room_bits.keys():
		draw_texture(room_bits.get(segment),segment * 64,placement_color)
			
	
