extends EnemyState
class_name EnemyPatrol

@onready var Pathing = get_ancestor(3)
@onready var last_position = enemy.global_position

var patrol_speed = 50
var can_patrol = true

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	print_debug("Patrol")
	$PatrolSoundPlayer.start()


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(delta: float) -> void:
	if round(enemy.global_position) != round(last_position) and not can_patrol:
		enemy.global_position = enemy.global_position.move_toward(last_position, patrol_speed * delta)
	elif round(enemy.global_position) == round(last_position) and not can_patrol:
		can_patrol = true
	elif can_patrol:
		Pathing.progress += patrol_speed * delta


func _on_detection_area_area_entered(area):
	if area.is_in_group("Player"):
		get_ancestor(2).player = area.get_parent()
		RayCastTimer.start()
	


func _on_patrol_sound_player_timeout():
	$EnemyPatrolPlayer.play()


func _on_ray_cast_timer_timeout():
	ray_cast.target_position = enemy.to_local(get_ancestor(2).player.position)
	if ray_cast.get_collider() == get_ancestor(2).player:
		can_patrol = false
		last_position = enemy.global_position
		transitioned.emit("chase")


func _on_detection_area_area_exited(area):
	RayCastTimer.stop()
