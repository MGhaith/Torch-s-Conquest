extends Node2D


@export_category("Nodes")
@export var win_check_collision: CollisionShape2D
@export var tile_map: TileMap

var win_condition = [false, false, false, false]
var done : bool 

func _ready():
	done = false

func _process(_delta):
	if win_condition.min() && !done:
		done = true
		$AudioStreamPlayer.play()
		win_check_collision.disabled = false
		tile_map.set_layer_enabled(3, true)
