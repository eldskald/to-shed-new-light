extends Spatial

onready var tween: Tween = $Tween

func snap_to(position: Vector3) -> void:
	if not tween.is_active():
		tween.interpolate_property(
			self, "translation", null, position, 0.5,
			Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.start()

