extends Spatial

onready var up_mat: Material = $MeshInstance.get_surface_material(3)
onready var left_mat: Material = $MeshInstance.get_surface_material(0)
onready var down_mat: Material = $MeshInstance.get_surface_material(1)
onready var right_mat: Material = $MeshInstance.get_surface_material(2)
onready var timer: Timer = $Timer

var brightness: Array = [0.6, 0.6, 0.6, 0.6]
var alpha: Array = [1.0, 1.0, 1.0, 1.0]

func _process(_delta) -> void:
	if not timer.is_stopped():
		for i in range(4):
			alpha[i] = 1 - timer.time_left
	up_mat.set_shader_param("brightness", brightness[0])
	up_mat.set_shader_param("alpha", alpha[0])
	left_mat.set_shader_param("brightness", brightness[1])
	left_mat.set_shader_param("alpha", alpha[1])
	down_mat.set_shader_param("brightness", brightness[2])
	down_mat.set_shader_param("alpha", alpha[2])
	right_mat.set_shader_param("brightness", brightness[3])
	right_mat.set_shader_param("alpha", alpha[3])

func _on_Timer_timeout():
	$Up/CollisionShape.disabled = false
	$Left/CollisionShape.disabled = false
	$Down/CollisionShape.disabled = false
	$Right/CollisionShape.disabled = false

func activate() -> void:
	if not $MeshInstance.visible:
		timer.start()
		$MeshInstance.visible = true
