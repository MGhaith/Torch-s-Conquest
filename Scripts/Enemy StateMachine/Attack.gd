extends EnemyState
class_name EnemyAttack

var player_in_area = false
var patrol_speed = 30

@export var AttackHitCooldown: Timer
@export var Delay: Timer

var attackSpeed = 5

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	print_debug("Attack")
	player_in_area = true
	player = get_ancestor(2).player
	player.removeHealth(10)
	AttackHitCooldown.start()
	


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(delta: float) -> void:
	if player_in_area:
		var direction = (player.global_position - enemy.global_position)
		enemy.velocity = direction * delta * attackSpeed
		enemy.move_and_slide()


func _on_attack_hit_cooldown_timeout():
	player.removeHealth(10)


func _on_detection_area_body_exited(body):
	player_in_area = false
	AttackHitCooldown.stop()
	transitioned.emit("chase")
	
