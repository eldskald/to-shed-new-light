extends TextureButton

onready var button: Button = $Button

func _ready() -> void:
	retext_button()

func retext_button() -> void:
	if OS.window_fullscreen:
		button.text = "Windowed"
	else:
		button.text = "Fullscreen"

func _on_Button_pressed():
	if OS.window_fullscreen:
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true
	retext_button()

func _on_pressed():
	button.visible = !button.visible
