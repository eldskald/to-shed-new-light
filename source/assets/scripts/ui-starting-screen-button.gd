extends Button

export(String) var unfocus_text
export(String) var focus_text

func _ready() -> void:
	connect("focus_entered", self, "_on_focus_entered")
	connect("focus_exited", self, "_on_focus_exited")

func _on_focus_entered() -> void:
	self.text = focus_text

func _on_focus_exited() -> void:
	self.text = unfocus_text
