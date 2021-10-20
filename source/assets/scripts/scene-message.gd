extends Control

export(float) var auto_activate_in

onready var timer = $Timer
onready var anim_player = $AnimationPlayer

signal on_activate

func _ready():
	pass
