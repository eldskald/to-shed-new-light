extends Spatial

onready var material: Material = $MeshInstance.get_surface_material(0)
onready var tween: Tween = $Tween
onready var sphere_grab_sfx: AudioStreamPlayer = $SphereGrab
onready var sphere_grab_sfx_tween: Tween = $SphereGrab/Tween

var reparent_call: Spatial = null
signal stage_cleared

func _physics_process(_delta):
	var lin_volume: float = inverse_lerp(-80, -4, sphere_grab_sfx.volume_db)
	material.set_shader_param("brightness", lerp(0.8, 1.2, lin_volume))
	if reparent_call != null:       # Can't reparent on an area_entered signal
		reparent_to(reparent_call)  # or else the game crashes, so we're doing
		reparent_call = null        # it on the next frame instead.

func reparent_to(new_parent: Spatial) -> void:
	var old_transform: Transform = global_transform
	get_parent().remove_child(self)
	new_parent.add_child(self)
	global_transform = old_transform

func snap_to(position: Vector3) -> void:
	tween.interpolate_property(
		self, "translation", null, position, 0.5,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()

func _on_Detector_area_entered(area) -> void:
	if area.is_in_group("goal"):
		emit_signal("stage_cleared")
		snap_to(area.translation)
	elif area.is_in_group("path_inside"):
		if not get_parent().is_a_parent_of(area):
			reparent_call = area.get_parent().get_parent()

func _on_grabbed_sphere() -> void:
	sphere_grab_sfx.volume_db = -80
	if sphere_grab_sfx_tween.is_active():
		sphere_grab_sfx_tween.stop(sphere_grab_sfx, "volume_db")
	sphere_grab_sfx_tween.interpolate_property(
		sphere_grab_sfx, "volume_db", null, -4, 0.5, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	sphere_grab_sfx_tween.start()

func _on_let_go_of_sphere() -> void:
	if sphere_grab_sfx_tween.is_active():
		sphere_grab_sfx_tween.stop(sphere_grab_sfx, "volume_db")
	sphere_grab_sfx_tween.interpolate_property(
		sphere_grab_sfx, "volume_db", null, -80, 0.5,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	sphere_grab_sfx_tween.start()
