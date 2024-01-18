extends ProgressBar

@export var player : CharacterBody2D

func _process(_delta):
	Update()

# Update the health bar
func Update():
	if player.playerHealth >= 0:
		value = player.playerHealth * 100 / player.maxHealth
	else:
		return
