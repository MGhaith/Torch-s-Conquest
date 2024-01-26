extends EnemyState
class_name EnemyChase

var player_in_area = false
var chase_speed

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	print_debug("Chase")
	$EnemyNoticePlayer.volume_db = 5
	$EnemyNoticePlayer.play()
	RayCastTimer.stop()
	
	chase_speed = 30
	player_in_area = true
	player = get_ancestor(2).player


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(delta: float) -> void:
	if player_in_area:
		var direction = (player.global_position - enemy.global_position)
		animation_direction = get_facing_direction(direction)
		enemy.velocity = direction * delta * chase_speed
		enemy.move_and_slide()
	
		match  animation_direction:
			"right":
				animator.play("Right")
			"left":
				animator.play("Left")
			"up":
				animator.play("Top")
			"down":
				animator.play("Bottom")


func _on_detection_area_area_exited(area):
	if area.is_in_group("Player"):
		player_in_area = false
		transitioned.emit("patrol")


func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		get_ancestor(2).player = body
		transitioned.emit("Attack")
