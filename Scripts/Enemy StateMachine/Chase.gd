extends EnemyState
class_name EnemyChase

var player_in_area = false
var patrol_speed = 10

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	print_debug("Chase")
	player_in_area = true
	player = get_ancestor(2).player


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(delta: float) -> void:
	if player_in_area:
		var direction = (player.global_position - enemy.global_position)
		enemy.velocity = direction * delta * patrol_speed
		enemy.move_and_slide()


func _on_detection_area_area_exited(area):
	if area.is_in_group("Player"):
		player_in_area = false
		transitioned.emit("patrol")
