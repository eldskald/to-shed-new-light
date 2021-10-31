extends Node

enum states {START_MENU, GAME, CREDITS}

export(String, DIR) var levels_directory
export(String) var level_prefix
export(String, FILE, "*.tscn") var start_menu
export(String, FILE, "*.tscn") var credits
export(states) var initial_state

onready var state: int setget set_state

var level_progress: int = 1

func set_state(new_value: int) -> void:
	if state == new_value:
		return
	match new_value:
		states.START_MENU:
			get_tree().change_scene(start_menu)
		states.GAME:
			level_progress = 1
			go_to_level(level_progress)
		states.CREDITS:
			get_tree().change_scene(credits)
	state = new_value

func _ready():
	state = initial_state

func stage_cleared():
	if self.state != states.GAME:
		return
	level_progress += 1
	go_to_level(level_progress)

func reset_level():
	if self.state != states.GAME:
		return
	go_to_level(level_progress)

func go_to_level(level: int) -> void:
	var level_file: String = levels_directory + "/"
	level_file += level_prefix + String(level) + ".tscn"
	var file_checker := File.new()
	if file_checker.file_exists(level_file):
		get_tree().change_scene(level_file)
	else:
		print("Game ended")
		get_tree().quit()
