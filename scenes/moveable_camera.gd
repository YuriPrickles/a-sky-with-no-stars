extends Camera2D
const MAX_ZOOM = 2.5
const MIN_ZOOM = 0.5
var targetzoom = -1
var last_mousepos = position
var movable = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not movable: return
	var movement = Input.get_vector("cam_left","cam_right","cam_up","cam_down")
	position += movement * 400 * delta
	
	if Input.is_action_pressed("move_camera"):
		var current_mousepos = get_global_mouse_position()
		position += ((last_mousepos - current_mousepos))
	else:
		last_mousepos = get_global_mouse_position()
	var newzoom = zoom.x
	if Input.is_action_just_released("mouse_wheel_up"):
		targetzoom = clamp(zoom.x + 0.25,MIN_ZOOM,MAX_ZOOM)
	if Input.is_action_just_released("mouse_wheel_down"):
		targetzoom = clamp(zoom.x - 0.25,MIN_ZOOM,MAX_ZOOM)
	if targetzoom != -1:
		newzoom = targetzoom
	zoom = Vector2(newzoom,newzoom)
