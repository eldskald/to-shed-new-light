extends Spatial
class_name BaseLevel

export(float) var stage_rotation_velocity

onready var stage: Spatial = get_node("Stage")
onready var camera_pivot: Spatial = get_node("CameraPivot")
onready var rotation_tween: Tween = get_node("RotationTween")


func rotate_pivot(button_name: String = "") -> void:
	var direction := camera_pivot.get_rotation_degrees()
	match button_name:
		"Z":
			direction = Vector3(0, 0, 90)
		"-Z":
			direction = Vector3(0, 0, -90)
		"Y":
			direction = Vector3(0, 90, 0)
		"-Y":
			direction = Vector3(0, -90, 0)
		"X":
			direction = Vector3(0, -90, 0)
		"-X":
			direction = Vector3(0, 0, 0)
	rotation_tween.interpolate_property(camera_pivot, "rotation_degrees", camera_pivot.get_rotation_degrees(), direction, 1, 
										Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	rotation_tween.start()
	return


func _on_Z_button_down():
	rotate_pivot("Z")

func _on_mZ_button_down():
	rotate_pivot("-Z")

func _on_Y_button_down():
	rotate_pivot("Y")

func _on_mY_button_down():
	rotate_pivot("-Y")

func _on_X_button_down():
	rotate_pivot("X")

func _on_mX_button_down():
	rotate_pivot("-X")
