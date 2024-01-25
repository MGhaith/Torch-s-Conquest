extends Node

@onready var audioPlayer : AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var endScreen : Control
@export var player : CharacterBody2D
@export var ost : AudioStreamOggVorbis
@export var menuOst : AudioStreamWAV

# Called when the node enters the scene tree for the first time.
func _ready():
	if menuOst != null:
		audioPlayer.set_stream(menuOst)
		audioPlayer.play()
	if player != null:
		BeginLevel()

# Set the rules to begin the level
func BeginLevel():
	player.StartHealthTimer()
	audioPlayer.stop()
	audioPlayer.set_stream(ost)
	audioPlayer.volume_db = 10
	audioPlayer.play()

# End Level
func EndLevel(endState : String):
	#endScreen.visible = true
	#endScreen.SetLabelText(endState)
	#audioPlayer.stop()
	pass


# Restart Level
func RestartLevel():
	get_tree().reload_current_scene()

#Pause the level
func PauseLevel():
	pass
