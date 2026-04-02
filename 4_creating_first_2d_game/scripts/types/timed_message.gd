class_name TimedMessage
extends Resource

@export var text: String = ""
@export var time: float = 1.0
@export var sfx: AudioStream = null

func _init(
	_text: String = "",
	_time: float = 1.0,
	_sfx: AudioStream = null):
	text = _text
	time = _time
	sfx = _sfx
