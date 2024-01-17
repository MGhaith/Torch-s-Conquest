extends Node

@onready var audioPlayer : AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var ost : AudioStreamWAV

# Called when the node enters the scene tree for the first time.
func _ready():
	audioPlayer.set_stream(ost)
	audioPlayer.play()
