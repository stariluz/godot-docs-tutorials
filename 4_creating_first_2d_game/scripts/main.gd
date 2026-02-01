extends Node

@export var mob_scene: PackedScene
@export var mobs_container: Node
var score: int

func new_game():
	get_tree().call_group("mobs", "queue_free")
	
	score=0
	$HUD.update_score(score)
	
	$HUD.show_message_and_wait("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$Music.play()


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
	$Music.stop()
	$DeathSound.play()

func _on_player_hit() -> void:
	game_over()

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
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
