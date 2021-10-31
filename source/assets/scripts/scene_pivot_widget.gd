extends Area

onready var mesh: MeshInstance = $MeshInstance
onready var timer: Timer = $Timer

var brightness: float = 0.6
var alpha: float = 1

func _process(_delta) -> void:
	if not timer.is_stopped():
		alpha = 1 - timer.time_left
	for i in range(mesh.get_surface_material_count()):
		mesh.get_surface_material(i).set_shader_param("brightness", brightness)
		mesh.get_surface_material(i).set_shader_param("alpha", alpha)

func _on_Timer_timeout() -> void:
	$CollisionShape.disabled = false

func activate() -> void:
	if not self.visible:
		timer.start()
		self.visible = true
