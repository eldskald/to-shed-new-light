extends Control

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var sfx: AudioStreamPlayer = $SelectSFX

func _ready() -> void:
	ScreenTransition.connect(
		"fade_out_finished", self, "_on_Transition_fade_out_finished")
	ScreenTransition.fade_in(3)
	anim_player.play("load")
	MusicPlayer.play(0)

func _on_Transition_fade_out_finished():
	GameStateMachine.set_state(GameStateMachine.states.GAME)

func _on_StartGame_pressed():
	sfx.play()
	ScreenTransition.fade_out()

func _on_Credits_pressed():
	sfx.play()
	anim_player.play("load_credits")

func _on_Return_pressed():
	sfx.play()
	anim_player.play("back_to_menu")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and anim_player.is_playing():
		if anim_player.assigned_animation == "load":
			sfx.play()
			var default_speed = anim_player.playback_speed
			anim_player.playback_speed = 9999
			yield(anim_player, "animation_finished")
			anim_player.playback_speed = default_speed



