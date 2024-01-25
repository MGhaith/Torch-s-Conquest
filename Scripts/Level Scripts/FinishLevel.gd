extends ShapeCast2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_colliding() && get_collider(0) != null:
		if get_collider(0).is_in_group("Player"):
			var player = get_collider(0)
			player.healthTimer.stop()
			player.canMove = false
