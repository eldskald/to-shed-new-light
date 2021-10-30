extends AnimationPlayer

# If you're not a developer and you're just checking out the source
# code of this game, get a load of this. Will change your life.
export(NodePath) onready var controls = get_node(controls) as Spatial

func reset_perspectives() -> void:
	controls.change_direction("Z", 2.5)
	controls.rotate_camera("Up", 2.5)

func _on_FirstGoal_area_entered(_area) -> void:
	play("first_to_second")
	ScreenTransition.play_sfx()

func _on_SecondGoal_area_entered(_area) -> void:
	play("second_to_third")
	ScreenTransition.play_sfx()
