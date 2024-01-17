extends Sprite2D


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		var door = get_parent().get_node("level/Door_Exit/Exit")
		door.OpenDoor()
		queue_free()
