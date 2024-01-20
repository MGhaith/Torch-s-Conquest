extends StaticBody2D


@export_category("Nodes")
@export var light : PointLight2D
@export var flashingTimer : Timer

func _ready():
	$AnimatedSprite2D.play("Lit")
	randomize()

# Flashing Light effect
func _on_torch_light_timer_timeout():
	var rand_amt := (randf())
	light.energy = rand_amt
	if rand_amt < 0.2:
		light.energy = 0.2
	elif rand_amt > 0.5:
		light.energy = 0.5
	flashingTimer.start(rand_amt / randf_range(1,20))
