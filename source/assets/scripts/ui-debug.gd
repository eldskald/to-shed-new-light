extends VBoxContainer

onready var level_label: Label = $Level
onready var fps_label: Label = $FPS

func _process(_delta):
	level_label.text = "Level " + GameStateMachine.level_progress as String
	fps_label.text = Engine.get_frames_per_second() as String + " fps"

func _on_ResetButton_pressed():
	GameStateMachine.reset_level()
