extends MeshInstance

onready var material_1: Material = get_surface_material(0)
onready var material_2: Material = get_surface_material(1)
onready var material_3: Material = get_surface_material(2)
onready var timer: Timer = $Timer

var brightness: float = 1
var alpha: float = 1

func _physics_process(_delta) -> void:
	if not timer.is_stopped():
		alpha = 1 - timer.time_left
	material_1.set_shader_param("brightness", brightness)
	material_2.set_shader_param("brightness", brightness)
	material_3.set_shader_param("brightness", brightness)
	material_1.set_shader_param("alpha", alpha)
	material_2.set_shader_param("alpha", alpha)
	material_3.set_shader_param("alpha", alpha)

func activate() -> void:
	if not self.visible:
		timer.start()
		self.visible = true
