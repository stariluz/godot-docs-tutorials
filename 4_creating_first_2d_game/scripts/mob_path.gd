extends Path2D

func _ready() -> void:
	set_points_on_viewport_size()

func set_points_on_viewport_size():
	var screen_size:Vector2 = get_viewport_rect().size
	curve.set_point_position(1,Vector2(screen_size.x,0))
	curve.set_point_position(2,Vector2(screen_size.x,screen_size.y))
	curve.set_point_position(3,Vector2(0,screen_size.y))
	print(curve.get_baked_points())
