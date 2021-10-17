extends HSlider

func _ready():
	self.value = db2linear(
		AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))

func _on_HSlider_value_changed(newvalue):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"), linear2db(newvalue))
