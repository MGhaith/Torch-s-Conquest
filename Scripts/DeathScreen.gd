extends Control

@export var canvas : CanvasLayer

func _ready():
	hide()
	canvas.game_manager.toggle_game_paused.connect(_on_game_manager_toggle_game_pause)

func _on_game_manager_toggle_game_pause(ispaused : bool):
	if ispaused && canvas.game_manager.passedHealth == 0:
		show()
	else :
		hide()
