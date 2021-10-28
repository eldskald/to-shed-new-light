extends Button

export(String) var unfocus_text
export(String) var focus_text

func _on_focus_entered() -> void:
	self.text = focus_text

func _on_focus_exited() -> void:
	self.text = unfocus_text
