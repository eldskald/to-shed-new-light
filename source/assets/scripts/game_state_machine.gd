extends Node

enum states {START_MENU, GAME, CREDITS}

export(String, DIR) var levels_derectory
export(String) var level_prefix
export(states) var initial_state

onready var state: int setget set_state

var level_progress: int = 0

func set_state(new_value: int) -> void:
	if state == new_value:
		return
	state = new_value
	match state:
		states.INITIAL_MENU:
			#Load Start Menu
			pass
		states.GAME:
			get_tree().change_scene(levels_derectory + "/"+ level_prefix + String(level_progress) + ".tscn")

func _ready():
	state = initial_state

func stage_cleared():
	if self.state != states.GAME:
		return
	
	level_progress += 1
	var level_file: String = levels_derectory + "/"+ level_prefix + String(level_progress) + ".tscn"
	var file_checker := File.new()
	if file_checker.file_exists(level_file):
		get_tree().change_scene(levels_derectory + "/"+ level_prefix + String(level_progress) + ".tscn")
	else:
		print("Game ended")
		get_tree().quit()
