extends Node

signal level_changed(next_level_name)

@export var next_level_name : String
@export var game_manager : GameManager
@export var player : CharacterBody2D
@export var pausable : bool
@export_category("Main Menu")
@export var controlsMenu : Control
@export var mainMenu : Control

@onready var levelNumber = $VBoxContainer/LevelNumber
@onready var levelName = $VBoxContainer/LevelName

func _on_play_button_pressed():
	emit_signal("level_changed", next_level_name)


func _on_controls_button_pressed():
	mainMenu.visible = false
	controlsMenu.visible = true


func _on_exit_button_pressed():
	get_tree().quit()

func _on_back_button_pressed():
	controlsMenu.visible = false
	mainMenu.visible = true

# LEVELNAME CODE
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

# Player Death Code
func _process(_delta):
	if player != null && player.playerHealth <= 0:
		player.light_nodes.visible = false
		game_manager.passedHealth = 0
		game_manager.game_paused = true

# Level Win Check Code
func _on_win_check_body_entered(body):
	if body.is_in_group("Player"):
		body.healthTimer.stop()
		game_manager.passedHealth = body.playerHealth
		body.canMove = false
		emit_signal("level_changed", next_level_name)


func _on_main_menu_button_pressed():
	game_manager.game_paused = false
	game_manager.handle_level_changed("main")


func _on_new_game_button_pressed():
	game_manager.game_paused = false
	game_manager.handle_level_changed("1")


func _on_ending_timer_timeout():
	emit_signal("level_changed", next_level_name)
