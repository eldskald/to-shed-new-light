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
	pass # Replace with function body.

func _on_Credits_pressed():
	anim_player.play("load_credits")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and $Credits.visible:
		anim_player.play("back_to_menu")
