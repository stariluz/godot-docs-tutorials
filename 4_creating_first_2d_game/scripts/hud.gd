extends CanvasLayer
class_name HUD

signal start_game

@export var home_message="Dodge the Creeps!"
@export var lose_message="Game Over"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_message_and_wait(text: String, timer: Timer=$MessageTimer):
	if timer:
		timer.start()
		$Message.text = text
		$Message.show()
		await timer.timeout
	else:
		$Message.text = text
		$Message.show()

func show_game_over():
	await show_message_and_wait(lose_message)
	await show_message_and_wait(home_message, $StartButtonSpawnTimer)
	$StartButton.show()

func update_score(score:int):
	$ScoreLabel.text=str(score)

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$Message.hide()
