extends Area2D

@export var gameManager: Node




func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.healthTimer.stop()
		body.canMove = false
		gameManager.EndLevel("You Win")
