extends Node

onready var button: TextureButton = $TextureButton
onready var slider: Slider = $HSlider

func _ready():
	slider.value = db2linear(
		AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))

func _on_HSlider_value_changed(newvalue):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"), linear2db(newvalue))

func _on_AudioButton_pressed():
	slider.visible = !slider.visible
