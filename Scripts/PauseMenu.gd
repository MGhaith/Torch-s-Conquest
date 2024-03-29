extends Control

signal level_changed(next_level_name)

@export var next_level_name : String
@export var canvas : CanvasLayer

func _ready():
	hide()
	canvas.game_manager.toggle_game_paused.connect(_on_game_manager_toggle_game_pause)

func _on_game_manager_toggle_game_pause(ispaused : bool):
	if ispaused && canvas.game_manager.passedHealth != 0:
		show()
	else :
		hide()

func _on_resume_button_pressed():
	canvas.game_manager.game_paused = false
