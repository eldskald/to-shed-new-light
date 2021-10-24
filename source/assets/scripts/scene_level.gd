extends Spatial
class_name BaseLevel

export(bool) var z_widget
export(bool) var nz_widget
export(bool) var x_widget
export(bool) var nx_widget
export(bool) var y_widget
export(bool) var ny_widget
export(bool) var ring_widget

onready var z = $CameraPivot/Camera/CameraControls/PivotWidget/Z
onready var nz = $CameraPivot/Camera/CameraControls/PivotWidget/nZ
onready var x = $CameraPivot/Camera/CameraControls/PivotWidget/X
onready var nx = $CameraPivot/Camera/CameraControls/PivotWidget/nX
onready var y = $CameraPivot/Camera/CameraControls/PivotWidget/Y
onready var ny = $CameraPivot/Camera/CameraControls/PivotWidget/nY
onready var cube = $CameraPivot/Camera/CameraControls/WidgetCube
onready var ring = $CameraPivot/Camera/CameraControls/RotationWidget
onready var up = $CameraPivot/Camera/CameraControls/RotationWidget/Up
onready var left = $CameraPivot/Camera/CameraControls/RotationWidget/Left
onready var down = $CameraPivot/Camera/CameraControls/RotationWidget/Down
onready var right = $CameraPivot/Camera/CameraControls/RotationWidget/Right

func _ready() -> void:
	$Transition.fade_in()
	if not z_widget:
		disable_widget(z)
	if not nz_widget:
		disable_widget(nz)
	if not x_widget:
		disable_widget(x)
	if not nx_widget:
		disable_widget(nx)
	if not y_widget:
		disable_widget(y)
	if not ny_widget:
		disable_widget(ny)
	if not (
		z_widget or nz_widget or x_widget or nx_widget or y_widget or ny_widget
	):
		cube.visible = false
	if not ring_widget:
		var mesh: MeshInstance = get_node(
			"CameraPivot/Camera/CameraControls/RotationWidget/MeshInstance")
		mesh.visible = false
		disable_widget(up)
		disable_widget(left)
		disable_widget(down)
		disable_widget(right)

func disable_widget(widget: Area) -> void:
	widget.visible = false
	widget.get_node("CollisionShape").disabled = true

func activate_widget(widget_name: String) -> void:
	match widget_name:
		"Z":
			z.activate()
			cube.activate()
		"nZ":
			nz.activate()
			cube.activate()
		"Y":
			y.activate()
			cube.activate()
		"nY":
			ny.activate()
			cube.activate()
		"X":
			x.activate()
			cube.activate()
		"nX":
			nx.activate()
			cube.activate()
		"Ring":
			ring.activate()
		"Cube":
			cube.activate()

func disable_controls() -> void:
	$CameraPivot/Camera/DragControls.enabled = false
	$CameraPivot/Camera/CameraControls/PivotRay.enabled = false
	$CameraPivot/Camera/CameraControls/RotRay.enabled = false

func _on_stage_cleared() -> void:
	GameStateMachine.get_node("StageTransitionSFX").play()
	$Transition.fade_out()
	disable_controls()

func _on_Transition_fade_out_finished() -> void:
	GameStateMachine.stage_cleared()
