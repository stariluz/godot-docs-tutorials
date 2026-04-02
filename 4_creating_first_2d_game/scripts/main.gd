extends Node

signal score_updated(score: int)
signal game_over(score: int)

@export var mob_scene: PackedScene
@export var mobs_container: Node
var score: int
var is_mobile=OS.has_feature("mobile")

func set_score(_score:int)->void:
	score=_score
	score_updated.emit(score)
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not is_mobile:
		$VirtualJoystick.queue_free()
	
func new_game():
	get_tree().call_group("mobs", "queue_free")
	
	set_score(0)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Music.play()


func end_game() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$Music.stop()
	game_over.emit(score)

func _on_player_hit() -> void:
	end_game()

func _on_mob_timer_timeout() -> void:
	var mob:Mob=mob_scene.instantiate()
	
	# Set position randomly in the path position
	var mob_spawn_location:MobSpawnLocation = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	
	# Set direction perpendicular first and then add randomness
	var direction = mob_spawn_location.rotation + mob_spawn_location.target_direction
	direction += randf_range(mob_spawn_location.min_angle, mob_spawn_location.max_angle)
	mob.rotation = direction
	
	# Set velocity randomly
	var velocity = Vector2(randf_range(mob.min_velocity, mob.max_velocity), 0.0)
	mob.linear_velocity=velocity.rotated(direction)
	
	# Spawn mob
	mobs_container.add_child(mob)

func _on_score_timer_timeout() -> void:
	set_score(score+1)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()

func _on_game_start() -> void:
	new_game()
