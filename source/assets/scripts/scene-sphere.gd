extends Spatial

onready var tween: Tween = $Tween

var reparent_call: Spatial = null

func _physics_process(_delta):
	if reparent_call != null:       # Can't reparent on an area_entered signal
		reparent_to(reparent_call)  # or else the game crashes, so we're doing
		reparent_call = null        # it on the next frame instead.

func reparent_to(new_parent: Spatial) -> void:
	var old_transform: Transform = global_transform
	get_parent().remove_child(self)
	new_parent.add_child(self)
	global_transform = old_transform

func snap_to(position: Vector3) -> void:
	if not tween.is_active():
		tween.interpolate_property(
			self, "translation", null, position, 0.5,
			Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.start()

func _on_Detector_area_entered(area) -> void:
	if area.is_in_group("goal"):
		GameStateMachine.stage_cleared()
	elif area.is_in_group("path_inside"):
		if not get_parent().is_a_parent_of(area):
			reparent_call = area.get_parent().get_parent()
