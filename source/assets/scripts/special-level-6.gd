extends Timer

onready var level: Spatial = get_parent()

signal changed_direction

func _on_timeout():
	level.activate_widget("Z")
	level.activate_widget("Y")

func _on_CameraControls_changed_view_direction(new_direction: String):
	if new_direction == "Y":
		emit_signal("changed_direction")
