extends Node

class_name GameManager

signal toggle_game_pauseed(is_paused: bool)

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_pauseed", game_paused)

@onready var current_level = $Menus

# Called when the node enters the scene tree for the first time.
func _ready():
	current_level.level_changed.connect(handle_level_changed)

func _input(event : InputEvent):
	if event.is_action_pressed("Pause"):
		game_paused = !game_paused

func handle_level_changed(next_level_name : String):
	var next_level
	var target_level_name
	
	match next_level_name:
		"main":
			target_level_name = "MainMenu"
		"0":
			target_level_name = "LevelName"
		"prototype":
			target_level_name = "PrototypingScene"
		"1":
			target_level_name = "LevelName"
		"level1":
			target_level_name = "Level1"
		"2":
			target_level_name = "LevelName"
		"level2":
			target_level_name = "level2"
		"3":
			target_level_name = "LevelName"
		"level3":
			target_level_name = "level3"
		"4":
			target_level_name = "LevelName"
		"level4":
			target_level_name = "level4"
		"5":
			target_level_name = "LevelName"
		"level5":
			target_level_name = "level2"
		"endscreen":
			target_level_name = "ending"
		_:
			printt("no next level")
			return
	
	next_level = load("res://Scenes/" + target_level_name + ".tscn").instantiate()
	add_child(next_level)
	next_level.level_changed.connect(handle_level_changed)
	
	if target_level_name == "LevelName":
		next_level.SetLabels(int(next_level_name))
	
	current_level.queue_free()
	current_level = next_level