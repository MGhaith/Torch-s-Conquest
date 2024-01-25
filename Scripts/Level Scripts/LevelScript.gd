extends Node

signal level_changed(next_level_name)

@export var next_level_name : String
@export var controlsMenu : Control
@export var mainMenu : Control
@export var game_manager : GameManager
@export var pauseMenu : Control

@onready var levelNumber = $VBoxContainer/LevelNumber
@onready var levelName = $VBoxContainer/LevelName

func _on_play_button_pressed():
	emit_signal("level_changed", next_level_name)
	#gameManager.StartNewGame()


func _on_controls_button_pressed():
	mainMenu.visible = false
	controlsMenu.visible = true


func _on_exit_button_pressed():
	get_tree().quit()

func _on_back_button_pressed():
	controlsMenu.visible = false
	mainMenu.visible = true

# LEVEL NAME CODE
# level name scene timer
func _on_timer_timeout():
	emit_signal("level_changed", next_level_name)

# level name setting labels
func SetLabels(level_Number : int):
	if levelNumber != null:
		if levelName != null:
			match level_Number:
				0:
					levelNumber.text = "Level 0:"
					levelName.text = "Prototype"
					next_level_name = "prototype"
				1:
					levelNumber.text = "Level 1:"
					levelName.text = "The First Corridor"
					next_level_name = "level1"
				2:
					levelNumber.text = "Level 2:"
					levelName.text = "Empty"
					next_level_name = "level2"
				3:
					levelNumber.text = "Level 3:"
					levelName.text = "Empty"
					next_level_name = "level3"
				4:
					levelNumber.text = "Level 4:"
					levelName.text = "Empty"
					next_level_name = "level4"
				5:
					levelNumber.text = "Level 5:"
					levelName.text = "Empty"
					next_level_name = "level5"
