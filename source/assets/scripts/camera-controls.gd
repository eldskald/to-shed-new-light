extends Spatial

onready var tween: Tween = $Tween
onready var raycast: RayCast = $RayCast
onready var pivot: Spatial = get_parent().get_parent()

var last_state: String = "Z"
var pivot_states: Dictionary = {
	"Z" : Vector3(0, 0, 90),
	"nZ" : Vector3(0, 180, -90),
	"X" : Vector3(-90, 90, 0),
	"nX" : Vector3(90, -90, 0),
	"Y" : Vector3(0, 0, 0),
	"nY" : Vector3(0, 0, 180)
}



func _physics_process(_delta) -> void:
	var state: String = get_pivot_state()
	if state != "none":
		light_pivot_widgets(state)
	else:
		light_pivot_widgets(last_state)
	
	update_raycast_position(raycast)
	raycast.force_raycast_update()
	if raycast.is_colliding():
		var c_widget: Area = raycast.get_collider()
		var c_mesh: MeshInstance = c_widget.get_node("MeshInstance")
		c_mesh.get_surface_material(1).set_shader_param("brightness", 1.1)
		if Input.is_action_just_pressed("click") and not tween.is_active():
			tween.interpolate_property(
				pivot, "rotation_degrees", null, pivot_states[c_widget.name],
				1, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
			tween.start()
			last_state = c_widget.name



func update_raycast_position(ray: RayCast) -> void:
	var viewport: Viewport = get_viewport()
	var camera: Camera = viewport.get_camera()
	var mouse_position: Vector2 = viewport.get_mouse_position()
	var unit_pos: Vector2 = Vector2(                 # Makes mouse pos coords
		2 * mouse_position.x / viewport.size.x - 1,  # range from -1 to 1 with
		2 * mouse_position.y / viewport.size.y - 1)  # (0,0) on screen center.
	ray.translation.x = unit_pos.x * camera.size / 2
	ray.translation.y = -unit_pos.y * camera.size / 2
	ray.translation.y *= viewport.size.y / viewport.size.x

func get_pivot_state() -> String:
	for key in pivot_states.keys():
		if pivot_states[key] == pivot.rotation_degrees:
			return key
	return "none"

func get_pivot_widget_by_name(state: String) -> Area:
	for widget in get_node("PivotWidget").get_children():
		if widget.name == state:
			return widget
	print("ERROR: Invalid get_pivot_widget_by_name() call!")
	return null

func light_pivot_widgets(state: String) -> void:
	var widget: Area = get_pivot_widget_by_name(state)
	var mesh: MeshInstance = widget.get_node("MeshInstance")
	mesh.get_surface_material(0).set_shader_param("brightness", 1.1)
	mesh.get_surface_material(1).set_shader_param("brightness", 1.1)
	for o_widget in get_node("PivotWidget").get_children():
		if o_widget.name != state:
			var o_mesh: MeshInstance = o_widget.get_node("MeshInstance")
			o_mesh.get_surface_material(0).set_shader_param("brightness", 0.6)
			o_mesh.get_surface_material(1).set_shader_param("brightness", 0.6)
