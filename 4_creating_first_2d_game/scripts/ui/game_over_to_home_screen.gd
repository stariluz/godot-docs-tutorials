extends LabeledTransition

@export var score_message:TimedMessage=preload("res://4_creating_first_2d_game/scripts/ui/default_game_over_score_timed_message_00.tres")

func show_score(score:int):
	$Score.hide();
	await get_tree().create_timer(score_message.time).timeout
	$Score.show();
	$Score/SubViewport/Text.text=score_message.text+str(score)
	if score_message.sfx:
		$ScoreSFX.stream=score_message.sfx
		$ScoreSFX.play()
	
func _on_game_over(score:int) -> void:
	_on_play()
	show_score(score)
