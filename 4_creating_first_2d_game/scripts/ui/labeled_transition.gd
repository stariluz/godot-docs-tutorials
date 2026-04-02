extends Control
class_name LabeledTransition

signal messages_end

@export var messages:Array[TimedMessage] = []
@export var wait_for_last_message:bool = true

func show_message_and_wait(message:TimedMessage):
	$Label/SubViewport/Text.text = message.text
	if message.sfx:
		$SFX.stream=message.sfx
		$SFX.play()
	await get_tree().create_timer(message.time).timeout

func play_transition()->void:
	show()
	var start_messages=messages.slice(0,-1)
	for message in start_messages:
		await show_message_and_wait(message)
	
	if not wait_for_last_message:
		messages_end.emit()
		await show_message_and_wait(messages[-1])
	else:
		await show_message_and_wait(messages[-1])
		messages_end.emit()
	hide()

func _on_play():
	play_transition()
