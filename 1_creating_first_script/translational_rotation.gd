extends Sprite2D

var speed = 400
var angular_speed = PI
var my_rotation=rotation

func _process(delta: float) -> void:
	my_rotation+= angular_speed*delta
	var velocity= Vector2.UP.rotated(my_rotation)*speed
	position+=velocity*delta
