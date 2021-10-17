extends Spatial

onready var tween: Tween = $Tween

func snap_to(position: Vector3) -> void:
	if not tween.is_active():
		tween.interpolate_property(
			self, "translation", null, position, 0.5,
			Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.start()



func _on_MainSphere_area_entered(area):
	if area.is_in_group("goal"):
		GameStateMachine.stage_cleared()
