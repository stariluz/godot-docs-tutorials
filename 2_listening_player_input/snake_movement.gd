extends Sprite2D

var speed = 400
var angular_speed = PI

func _process(delta: float) -> void:
	var direction=0
	var is_left_pressed=Input.is_action_pressed("ui_left")
	var is_right_pressed=Input.is_action_pressed("ui_right")
	
	if is_left_pressed:
		direction=-1
		if is_right_pressed:
			direction=0
	elif is_right_pressed:
		direction=1
		
	rotation += angular_speed*direction*delta
	
	var velocity=Vector2.UP.rotated(rotation)*speed
	position+=velocity* delta
