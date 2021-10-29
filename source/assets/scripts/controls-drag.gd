extends RayCast

onready var sphere: Spatial = null
onready var path: Spatial = null

var last_mouse_pos: Vector2 = Vector2.ZERO

signal grabbed_sphere
signal let_go_of_sphere

func _physics_process(_delta: float) -> void:
	update_raycast_position()
	
	# First, let's check if the player grabbed the sphere.
	if Input.is_action_just_pressed("click"):
		sphere = find_sphere()
		if sphere != null:
			add_exception(sphere)
			path = find_path()
			if path != null:
				emit_signal("grabbed_sphere")
				sphere.global_transform.origin = get_collision_point()
			else:
				sphere = null
				clear_exceptions()
	
	# If there is a sphere, either from this frame or from a previous
	# one, let's now check to see if the player is dragging it.
	elif Input.is_action_pressed("click") and sphere != null:
		var new_path = find_path() # In order to remember last frame's path.
		if new_path != null:
			path = new_path
			var new_mouse_pos: Vector2 = get_mouse_position_in_3d_units()
			if (new_mouse_pos - last_mouse_pos).length() < 0.5:
				sphere.global_transform.origin = get_collision_point()
			else:
				let_go_of_sphere()
		else:
			let_go_of_sphere() # Snap sphere to last frame's path center.
	
	# Check if the player had just let go of the sphere.
	elif Input.is_action_just_released("click") and sphere != null:
		let_go_of_sphere() # Snap sphere to current frame's path center.
	
	# Lastly, we record the mouse position. We need it on the dragging part
	# of the code to prevent the player from flicking the mouse too quick,
	# which could allow the sphere to teleport long distances from a valid
	# position to another valid position which have a barrier or a gap in
	# between them, so we have to force the player to move slower.
	last_mouse_pos = get_mouse_position_in_3d_units()

func get_mouse_position_in_3d_units() -> Vector2:
	var viewport: Viewport = get_viewport()
	var camera: Camera = viewport.get_camera()
	var mouse_position: Vector2 = viewport.get_mouse_position()
	var unit_pos: Vector2 = Vector2(                 # Makes mouse pos coords
		2 * mouse_position.x / viewport.size.x - 1,  # range from -1 to 1 with
		2 * mouse_position.y / viewport.size.y - 1)  # (0,0) on screen center.
	var r: Vector2 = Vector2.ZERO
	r.x = unit_pos.x * camera.size / 2
	r.y = -unit_pos.y * camera.size * viewport.size.y / (2 * viewport.size.x)
	return r

func update_raycast_position() -> void:
	var coords: Vector2 = get_mouse_position_in_3d_units()
	self.translation.x = coords.x
	self.translation.y = coords.y

func find_sphere() -> Object:
	force_raycast_update()
	if self.is_colliding():
		if get_collider().is_in_group("main_sphere"):
			return get_collider()
	return null

func find_path() -> Object:
	force_raycast_update()
	if self.is_colliding():
		if get_collider().is_in_group("path"):
			return get_collider()
	return null

func let_go_of_sphere() -> void:
	sphere.snap_to(path.translation)
	sphere = null
	path = null
	clear_exceptions()
	emit_signal("let_go_of_sphere")

func is_grabbing_sphere() -> bool:
	return sphere != null
