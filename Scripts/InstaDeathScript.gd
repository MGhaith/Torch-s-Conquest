extends Area2D


func _on_body_entered(body):
	body.removeHealth(1000)
