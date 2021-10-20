extends Spatial

export(float) var alpha

onready var mesh: MeshInstance = $MeshInstance
onready var anim_player: AnimationPlayer = $AnimationPlayer

func _physics_process(_delta) -> void:
	var material = mesh.get_surface_material(0)
	material.set_shader_param("color", Color(1.0, 1.0, 1.0, alpha))

func activate() -> void:
	anim_player.play("activate")

func deactivate() -> void:
	anim_player.play("deactivate")

func _on_animation_finished(anim_name):
	if anim_name == "activate":
		anim_player.play("point_forward")
