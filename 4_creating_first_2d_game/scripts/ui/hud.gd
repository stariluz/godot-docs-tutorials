extends CanvasLayer
class_name HUD

signal play_actuated
signal game_start
signal game_over(score:int)
signal home_actuated

func play_action()->void:
	$HomeScreen.hide()
	play_actuated.emit()
	
func home_action()->void:
	$HomeScreen.show()
	home_actuated.emit()
	
func start_game()->void:
	$PlayScreen.show()
	game_start.emit()
	
func update_score(score:int):
	$PlayScreen/ScoreLabel.text=str(score)

func show_game_over(score:int):
	$PlayScreen.hide()
	game_over.emit(score)

func _on_start_button_pressed() -> void:
	play_action()
	
func _on_game_start_transition_ends() -> void:
	start_game()
	
func _on_game_over_transition_ends() -> void:
	home_action()

func _on_score_updated(score: int) -> void:
	update_score(score)

func _on_game_over(score: int) -> void:
	show_game_over(score)
