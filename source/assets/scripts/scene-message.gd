extends Control

export(float) var auto_activate_in
export(float) var deactivate_after

onready var timer = $Timer
onready var anim_player = $AnimationPlayer

signal on_activate
signal on_deactivate

func _ready() -> void:
	if auto_activate_in > 0:
		timer.start(auto_activate_in)

func _on_timer_timeout() -> void:
	if self.modulate.a == 0:
		activate()
	else:
		deactivate()

func activate() -> void:
	anim_player.play("activate")
	emit_signal("on_activate")
	if deactivate_after > 0:
		timer.start(deactivate_after)

func deactivate() -> void:
	anim_player.play("deactivate")
	emit_signal("on_deactivate")
