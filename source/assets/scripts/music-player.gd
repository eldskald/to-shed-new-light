extends Node

onready var tween: Tween = $Tween
onready var bgms: Array = [$BGM1, $BGM2, $BGM3, $BGM4]

var currently_playing: int = -1
var next_playing: int = -1

func play(song: int) -> void:
	if currently_playing == -1:
		bgms[song].volume_db = -9
		bgms[song].play()
		currently_playing = song
	elif song != currently_playing:
		stop(bgms[currently_playing])
		next_playing = song

func stop(node: AudioStreamPlayer) -> void:
	tween.interpolate_property(
		node, "volume_db", null, -80, 1, Tween.TRANS_EXPO, Tween.EASE_IN)
	tween.start()

func _on_tween_completed(object, _key):
	bgms[next_playing].volume_db = -9
	bgms[next_playing].play()
	object.stop()
	currently_playing = next_playing
