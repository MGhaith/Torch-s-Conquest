extends StaticBody2D


@export_category("Nodes")
@export var light : PointLight2D
@export var flashingTimer : Timer
@export var interaction_area: InteractionArea
@export var tile_map: TileMap
@export var win_check_collision: CollisionShape2D

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
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
	
	
func _on_interact():
	tile_map.set_layer_enabled(3, true)
	win_check_collision.disabled = false
