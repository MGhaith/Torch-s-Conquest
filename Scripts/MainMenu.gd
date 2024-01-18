extends Control

@export var gameManager : Node

func _on_play_button_pressed():
	self.visible = false
	gameManager.BeginLevel()


func _on_options_button_pressed():
	pass # Replace with function body.



func _on_exit_button_pressed():
	get_tree().quit()
