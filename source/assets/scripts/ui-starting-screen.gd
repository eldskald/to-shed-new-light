extends Control

onready var transition: Node = $Transition
onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	transition.fade_in(3)
	anim_player.play("load")

func _on_Transition_fade_out_finished():
	pass # Replace with function body.

# Chama um transition.fade_out() ao invés de carregar o primeiro
# nível direto, e carrega o primeiro nível no _on_Transition_fade_out_finished.
func _on_StartGame_pressed():
	anim_player.play("to_game")
	yield(anim_player, "animation_finished")
	GameStateMachine.set_state(GameStateMachine.states.GAME)

func _on_Credits_pressed():
	anim_player.play("load_credits")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if $Credits.visible and !anim_player.is_playing():
			anim_player.play("back_to_menu")
		elif anim_player.is_playing():
			var default_speed = anim_player.playback_speed
			anim_player.playback_speed = 9999
			yield(anim_player, "animation_finished")
			anim_player.playback_speed = default_speed
