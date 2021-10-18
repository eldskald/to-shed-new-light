extends Spatial

export(bool) var z_widget
export(bool) var nz_widget
export(bool) var x_widget
export(bool) var nx_widget
export(bool) var y_widget
export(bool) var ny_widget
export(bool) var ring_widget

func _ready() -> void:
	if not z_widget:
		disable_widget(get_node(
			"CameraPivot/Camera/CameraControls/PivotWidget/Z"))
	if not nz_widget:
		disable_widget(get_node(
			"CameraPivot/Camera/CameraControls/PivotWidget/nZ"))
	if not x_widget:
		disable_widget(get_node(
			"CameraPivot/Camera/CameraControls/PivotWidget/X"))
	if not nx_widget:
		disable_widget(get_node(
			"CameraPivot/Camera/CameraControls/PivotWidget/nX"))
	if not y_widget:
		disable_widget(get_node(
			"CameraPivot/Camera/CameraControls/PivotWidget/Y"))
	if not ny_widget:
		disable_widget(get_node(
			"CameraPivot/Camera/CameraControls/PivotWidget/nY"))
	if not ring_widget:
		var mesh: MeshInstance = get_node(
			"CameraPivot/Camera/CameraControls/RotationWidget/MeshInstance")
		mesh.visible = false
		disable_widget(get_node(
			"CameraPivot/Camera/CameraControls/RotationWidget/Up"))
		disable_widget(get_node(
			"CameraPivot/Camera/CameraControls/RotationWidget/Left"))
		disable_widget(get_node(
			"CameraPivot/Camera/CameraControls/RotationWidget/Down"))
		disable_widget(get_node(
			"CameraPivot/Camera/CameraControls/RotationWidget/Right"))

func disable_widget(widget: Area) -> void:
	widget.visible = false
	widget.get_node("CollisionShape").disabled = true



