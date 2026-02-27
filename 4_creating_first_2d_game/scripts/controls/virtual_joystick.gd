extends Control
class_name VirtualJoystick
@export var is_enabled:bool = false
@export var sensibility:float = 0.5
@export var stick_max_radius:float=1

var is_active:bool = false
var direction:Vector2 = Vector2.ZERO

var is_screen_touched = false
var pointer_position:Vector2 = Vector2.ZERO
var anchor_position:Vector2 = Vector2.ZERO
var value:Vector2 = Vector2.ZERO

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if is_screen_touched:
		update_stick()
	else:
		value=Vector2.ZERO

func _input(event:InputEvent):
	if event is InputEventScreenTouch:
		if event.pressed:
			is_screen_touched = true
			anchor_position = event.position
			show_joystick()
		elif event.released:
			is_screen_touched = false
			hide_joystick()
	elif event is InputEventScreenDrag:
		pointer_position = event.position
		
	
	# Debug with mouse
	if event is InputEventMouseButton:
		if event.pressed:
			is_screen_touched = true
			anchor_position = event.position
			show_joystick()
		elif event.is_released():
			is_screen_touched = false
			hide_joystick()
	elif event is InputEventMouseMotion:
		pointer_position = event.position


func show_joystick():
	position=anchor_position
	pointer_position=anchor_position
	show()

func hide_joystick():
	hide()

func update_stick():
	var new_position:Vector2 =(pointer_position-anchor_position)*sensibility
	var limits:Vector2 =(stick_max_radius*$Background.get_rect().size)/2
	
	if(new_position.length()>limits.x):
		new_position=new_position.normalized()*limits
	
	$Background/Stick.position=new_position
	
	value=new_position/limits
