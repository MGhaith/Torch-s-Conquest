extends EnemyState
class_name EnemyPatrol

@onready var Pathing = get_ancestor(3)
@onready var initial_position = enemy.global_position

var patrol_speed = 50
var can_patrol = true

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	print_debug("Patrol")
	can_patrol = false
	


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(delta: float) -> void:
	if enemy.global_position != initial_position and not can_patrol:
		enemy.global_position.move_toward(initial_position, patrol_speed * delta)
	else:
		Pathing.progress += patrol_speed * delta
		can_patrol = true


func _on_detection_area_area_entered(area):
	if area.is_in_group("Player"):
		get_ancestor(2).player = area.get_parent()
		transitioned.emit("chase")
