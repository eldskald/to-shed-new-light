extends Timer

onready var level: Spatial = get_parent()

var second_timer: bool = false

signal changed_direction

func _on_timeout():
	if not second_timer:
		level.activate_widget("Z")
		level.activate_widget("Y")
	else:
		emit_signal("changed_direction")

func _on_CameraControls_changed_view_direction(new_direction: String):
	if new_direction == "Y":
		self.start(1)
		second_timer = true
