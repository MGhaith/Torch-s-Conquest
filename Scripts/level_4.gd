extends Node2D


@export_category("Nodes")
@export var gameManager: Node
@export var tile_map: TileMap
@export var winCheckCollision: CollisionShape2D

var win_condition = [false, false, false, false]


func _process(delta):
	if win_condition.min():
		tile_map.set_layer_enabled(3, true)
		winCheckCollision.disabled = false
	print(win_condition)
