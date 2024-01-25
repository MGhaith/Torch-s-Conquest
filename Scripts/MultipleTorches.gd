extends Node2D


@export_category("Nodes")
@export var win_check_collision: CollisionShape2D
@export var tile_map: TileMap

var win_condition = [false, false, false, false]


func _process(delta):
	if win_condition.min():
		win_check_collision.disabled = false
		tile_map.set_layer_enabled(3, true)
		
	print(win_condition)
		
