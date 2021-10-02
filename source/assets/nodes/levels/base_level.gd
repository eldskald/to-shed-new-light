extends Spatial
class_name BaseLevel

export(NodePath) var stage_path

onready var stage: Spatial = get_node(stage_path)
onready var camera: Camera = get_node("Camera")
onready var rotation_tween: Tween = get_node("RotationTween")

#The child node "Stage" wil be where the props will stay, like stage in a play (Name can be changed to Scenario?)

func _unhandled_input(event):
	if event.is_echo():
		return
	if event.is_action_pressed("ui_up"):
		rotate_object_to_camera(stage, Vector2.UP)
	elif event.is_action_pressed("ui_down"):
		rotate_object_to_camera(stage, Vector2.DOWN)
	elif event.is_action_pressed("ui_left"):
		rotate_object_to_camera(stage, Vector2.LEFT)
	elif event.is_action_pressed("ui_right"):
		rotate_object_to_camera(stage, Vector2.RIGHT)

#Perspetive change functions
#PROPOSAL: Rotate only level, keep the camera fexed
func rotate_object_to_camera(object:Spatial, direction: Vector2) -> void:
	#TODO: Animate the rotation, TWEEN maybe?
	match direction:
		Vector2.UP, Vector2.DOWN:
			object.rotate(camera.transform.basis.x, PI/2*direction.y)
			pass
		Vector2.RIGHT, Vector2.LEFT:
			object.rotate(camera.transform.basis.y, PI/2*direction.x)
			pass
	return
