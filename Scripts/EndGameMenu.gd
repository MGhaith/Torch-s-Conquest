extends Control

@export var gameManager : Node
@onready var label : Label = $"MarginContainer/VBoxContainer/Label"

func _ready():
	self.visible = false

func SetLabelText(value : String):
	label.set_text(value)

func _on_main_menu_button_pressed():
	gameManager.RestartLevel()


func _on_exit_button_pressed():
	get_tree().quit()
