extends Spatial

onready var tween: Tween = $Tween
onready var pivot_ray: RayCast = $PivotRay
onready var rot_ray: RayCast = $RotRay
onready var pivot: Spatial = get_parent().get_parent()
onready var camera: Spatial = get_parent()

var last_pivot_state: String = "Z"
var last_rot_state: String = "Up"

var pivot_states: Dictionary = {
	"Z" : Vector3(0, 0, 90),
	"nZ" : Vector3(0, 180, -90),
	"X" : Vector3(-90, 90, 0),
	"nX" : Vector3(90, -90, 0),
	"Y" : Vector3(0, 0, 0),
	"nY" : Vector3(0, 0, 180)
}

var rot_states: Dictionary = {
	"Up" : Vector3(0, 90, 0),
	"Left" : Vector3(0, 90, -90),
	"Down" : Vector3(0, 90, 180),
	"Right" : Vector3(0, 90, 90)
}

var rot_materials: Dictionary = {
	"Up" : 0,
	"Left" : 1,
	"Down" : 2,
	"Right" : 3
}

#onready var rot_materials: Dictionary = {
#	"Up" : [$RotationWidget.up_brightness, $RotationWidget.up_alpha],
#	"Left" : [$RotationWidget.left_brightness, $RotationWidget.left_alpha],
#	"Down" : [$RotationWidget.down_brightness, $RotationWidget.down_alpha],
#	"Right" : [$RotationWidget.right_brightness, $RotationWidget.right_alpha]
#}



func _physics_process(_delta) -> void:
	var pivot_state: String = get_pivot_state()
	if pivot_state != "none":
		light_pivot_widgets(pivot_state)
	else:
		light_pivot_widgets(last_pivot_state)
	
	update_raycast_position(pivot_ray)
	pivot_ray.force_raycast_update()
	if pivot_ray.is_colliding():
		var c_widget: Area = pivot_ray.get_collider()
		c_widget.brightness = 1.1
		if Input.is_action_just_pressed("click") and not tween.is_active():
			tween.interpolate_property(
				pivot, "rotation_degrees", null, pivot_states[c_widget.name],
				1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
			tween.start()
			last_pivot_state = c_widget.name
	
	var rot_state: String = get_rot_state()
	if rot_state != "none":
		light_rot_widget(rot_state)
	else:
		light_rot_widget(last_rot_state)
	
	update_raycast_position(rot_ray)
	rot_ray.force_raycast_update()
	if rot_ray.is_colliding():
		var c_widget: String = rot_ray.get_collider().name
		var rot_widget = $RotationWidget
		rot_widget.brightness[rot_materials[c_widget]] = 1.1
		if Input.is_action_just_pressed("click") and not tween.is_active():
			tween.interpolate_property(
				camera, "rotation_degrees", null, rot_states[c_widget],
				1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
			tween.start()
			last_rot_state = c_widget
		



func update_raycast_position(ray: RayCast) -> void:
	var viewport: Viewport = get_viewport()
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
	for widget in get_node("PivotWidget").get_children():
		if widget.name == state:
			widget.brightness = 1.1
		else:
			widget.brightness = 0.6



func get_rot_state() -> String:
	for key in rot_states.keys():
		if rot_states[key] == camera.rotation_degrees:
			return key
	return "none"

func light_rot_widget(state: String) -> void:
	var rot_widget = $RotationWidget
	for key in rot_states.keys():
		if key == state:
			rot_widget.brightness[rot_materials[key]] = 1.1
		else:
			rot_widget.brightness[rot_materials[key]] = 0.6
