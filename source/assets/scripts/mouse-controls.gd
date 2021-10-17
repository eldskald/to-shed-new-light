extends RayCast

onready var sphere: Spatial = null
onready var path: Spatial = null

func _physics_process(_delta: float) -> void:
	update_raycast_position()
	
	if Input.is_action_pressed("click"):
		
		# First, let's try to grab the sphere.
		force_raycast_update()
		if sphere == null:
			force_raycast_update()
			if self.is_colliding():
				if get_collider().is_in_group("main_sphere"):
					sphere = get_collider() # Remember sphere for next frame.
					add_exception(sphere)
					force_raycast_update()
		
		# Now, if there is a sphere grabbed, let's search for paths.
		if sphere != null:
			if self.is_colliding():
				if get_collider().is_in_group("path"):
					path = get_collider() # Remember path for next frame.
					drag_sphere(get_collision_point())
				
				# In case we don't find a path, we use last frame's path
				# value to snap the sphere to the its center.
				elif path != null:
					let_go_of_sphere()
			elif path != null:
				let_go_of_sphere()
	
	# Now, letting go of the sphere by letting go of the mouse button.
	if Input.is_action_just_released("click"):
		if sphere != null and path != null:
			let_go_of_sphere()



func update_raycast_position() -> void:
	var viewport: Viewport = get_viewport()
	var camera: Camera = get_parent()
	var mouse_position: Vector2 = viewport.get_mouse_position()
	var unit_pos: Vector2 = Vector2(                 # Makes mouse pos coords
		2 * mouse_position.x / viewport.size.x - 1,  # range from -1 to 1 with
		2 * mouse_position.y / viewport.size.y - 1)  # (0,0) on screen center.
	self.translation.x = unit_pos.x * camera.size / 2
	self.translation.y = -unit_pos.y * camera.size / 2
	self.translation.y *= viewport.size.y / viewport.size.x

func drag_sphere(new_position: Vector3) -> void:
	var offset: Vector3 = new_position - sphere.to_global(Vector3.ZERO)
	sphere.global_translate(offset)

func let_go_of_sphere() -> void:
	sphere.snap_to(path.translation)
	sphere = null
	path = null
	clear_exceptions()

