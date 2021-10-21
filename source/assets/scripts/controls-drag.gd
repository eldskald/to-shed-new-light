extends RayCast

onready var sphere: Spatial = null
onready var path: Spatial = null

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
				drag_sphere(get_collision_point())
			else:
				sphere = null
				clear_exceptions()
	
	# If there is a sphere, either from this frame or from a previous
	# one, let's now check to see if the player is dragging it.
	elif Input.is_action_pressed("click") and sphere != null:
		var new_path = find_path() # In order to remember last frame's path.
		if new_path != null:
			path = new_path
			drag_sphere(get_collision_point())
		else:
			let_go_of_sphere() # Snap sphere to last frame's path center.
	
	# Lastly, to check if the player had just let go of the sphere.
	elif Input.is_action_just_released("click") and sphere != null:
		let_go_of_sphere() # Snap sphere to current frame's path center.



func update_raycast_position() -> void:
	var viewport: Viewport = get_viewport()
	var camera: Camera = viewport.get_camera()
	var mouse_position: Vector2 = viewport.get_mouse_position()
	var unit_pos: Vector2 = Vector2(                 # Makes mouse pos coords
		2 * mouse_position.x / viewport.size.x - 1,  # range from -1 to 1 with
		2 * mouse_position.y / viewport.size.y - 1)  # (0,0) on screen center.
	self.translation.x = unit_pos.x * camera.size / 2
	self.translation.y = -unit_pos.y * camera.size / 2
	self.translation.y *= viewport.size.y / viewport.size.x

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

func drag_sphere(new_position: Vector3) -> void:
	var offset: Vector3 = new_position - sphere.to_global(Vector3.ZERO)
	sphere.global_translate(offset)

func let_go_of_sphere() -> void:
	sphere.snap_to(path.translation)
	sphere = null
	path = null
	clear_exceptions()
	emit_signal("let_go_of_sphere")

func is_grabbing_sphere() -> bool:
	return sphere != null

