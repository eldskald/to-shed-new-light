extends Label

export(bool) var start_active
export(float) var auto_activate_in
export(float) var deactivate_after

onready var timer = $Timer
onready var anim_player = $AnimationPlayer

signal activated
signal deactivated

func _ready() -> void:
	if start_active:
		self.modulate.a = 1
		if deactivate_after > 0:
			timer.start(deactivate_after)
	else:
		self.modulate.a = 0
		if auto_activate_in > 0:
			timer.start(auto_activate_in)

func _on_timer_timeout() -> void:
	if not is_active():
		activate()
	else:
		deactivate()

func is_active() -> bool:
	return self.modulate.a > 0

func activate() -> void:
	if not is_active():
		anim_player.play("activate")
		emit_signal("activated")
		if deactivate_after > 0:
			timer.start(deactivate_after)

func deactivate() -> void:
	if is_active():
		anim_player.play("deactivate")
		emit_signal("deactivated")
