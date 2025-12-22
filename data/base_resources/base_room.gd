class_name BaseRoom
extends Resource

@export_category("Basic Info")
@export var room_name:String = "Placeholder Room"
@export_multiline var room_desc:String = "This room is a placeholder."

@export_category("Resource Costs")
@export var build_cost:Dictionary[State.ResourceType,int]
@export var maintenance_cost:Dictionary[State.ResourceType,int]
@export var needs_oxygen = true
##How many pioneers can be assigned here at maximum.[br]e.g. Barracks can have 5 workers
@export var max_worker_count:int

@export_category("Size Info")
@export var size_type:Enums.SizeType
@export var square_size:Vector2 = Vector2(1,1)
@export var tetrominos:Array[Vector2]
##Each square the room occupies will provide oxygen in a square of (x,y) centered around it.[br]
##Odd values only, please.
@export var oxygen_squarius:Vector2

func on_next_turn():
	pass
