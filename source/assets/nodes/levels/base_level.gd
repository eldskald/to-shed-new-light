extends Spatial
class_name BaseLevel

enum rotation_states {IDLE, ROT_LEFT, ROT_RIGHT, ROT_UP, ROT_DOWN}

export(NodePath) var stage_path
export(float) var stage_rotation_velocity

onready var stage: Spatial = get_node(stage_path)
onready var camera: Camera = get_node("Camera")
onready var rotation_tween: Tween = get_node("RotationTween")
onready var rotation_state: int = rotation_states.IDLE

var rotated_angle: float

#The child node "Stage" wil be where the props will stay, like stage in a play (Name can be changed to Scenario?)

func set_rotation_state(new_state: int):
	rotation_state = new_state
	rotated_angle = 0

func _unhandled_input(event):
	if event.is_echo() or rotation_state != rotation_states.IDLE:
		return
	if event.is_action_pressed("ui_up"):
		set_rotation_state(rotation_states.ROT_UP)
	elif event.is_action_pressed("ui_down"):
		set_rotation_state(rotation_states.ROT_DOWN)
		#rotate_object_to_camera(stage, Vector2.DOWN)
	elif event.is_action_pressed("ui_left"):
		set_rotation_state(rotation_states.ROT_LEFT)
		#rotate_object_to_camera(stage, Vector2.LEFT)
	elif event.is_action_pressed("ui_right"):
		set_rotation_state(rotation_states.ROT_RIGHT)
		#rotate_object_to_camera(stage, Vector2.RIGHT)

func _physics_process(delta):
	print(rotated_angle)
	var direction: Vector2
	match rotation_state:
		rotation_states.ROT_UP:
			direction = Vector2.UP
		rotation_states.ROT_DOWN:
			direction = Vector2.DOWN
		rotation_states.ROT_LEFT:
			direction = Vector2.LEFT
		rotation_states.ROT_RIGHT:
			direction = Vector2.RIGHT
		rotation_states.IDLE:
			direction = Vector2.ZERO
	rotate_object_to_camera(stage, direction, delta)

#Perspetive change functions
#PROPOSAL: Use tween to smooth the animation
func rotate_object_to_camera(object:Spatial, direction: Vector2, delta: float) -> void:
	match direction:
		Vector2.UP, Vector2.DOWN:
			var rotation_amount: float = stage_rotation_velocity*delta*direction.y
			if abs(rotated_angle + direction.y*rotation_amount) > PI/2:
				rotation_amount = direction.y*(PI/2 - rotated_angle)
				rotation_state = rotation_states.IDLE
			else:
				rotated_angle += direction.y*rotation_amount
			object.rotate_object_local(camera.transform.basis.x, rotation_amount)
		Vector2.RIGHT, Vector2.LEFT:
			var rotation_amount: float = stage_rotation_velocity*delta*direction.x
			if abs(rotated_angle + direction.x*rotation_amount) > PI/2:
				rotation_amount = direction.x*(PI/2 - rotated_angle)
				rotation_state = rotation_states.IDLE
			else:
				rotated_angle += direction.x*rotation_amount
			object.rotate(camera.transform.basis.y, rotation_amount)
	return
