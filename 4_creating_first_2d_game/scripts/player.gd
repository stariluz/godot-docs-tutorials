extends Area2D

signal hit

@export var speed:int = 400

var screen_size:Vector2
var is_mobile=OS.has_feature("mobile")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size= get_viewport_rect().size
	hide()

func start(pos:Vector2):
	self.position=pos
	show()
	$CollisionShape2D.disabled=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity:Vector2=Vector2.ZERO
	if is_mobile:
		var joystick:VirtualJoystick=get_tree().current_scene.get_node("VirtualJoystick")
		if joystick:
			velocity=joystick.value
		else:
			print_debug("Missing VirtualJoystick in scene")
	else:
		velocity=native_value()
		
	if velocity.length() > 0:
		velocity*=speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity*delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x!=0:
		$AnimatedSprite2D.animation="walk"
		$AnimatedSprite2D.flip_v=false
		$AnimatedSprite2D.flip_h=velocity.x<0
	elif velocity.y!=0:
		$AnimatedSprite2D.animation="up"
		$AnimatedSprite2D.flip_v=velocity.y>0
	
func _on_body_entered(_body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func native_value()->Vector2:
	var value:Vector2=Vector2.ZERO
	if(Input.is_action_pressed("move_right")):
		value.x+=1
	if(Input.is_action_pressed("move_left")):
		value.x-=1
	if(Input.is_action_pressed("move_up")):
		value.y-=1
	if(Input.is_action_pressed("move_down")):
		value.y+=1
	return value.normalized()
