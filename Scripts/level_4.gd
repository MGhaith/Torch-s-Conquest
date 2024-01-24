extends Node2D


@export var gameManager: Node
@export var tile_set: TileSet

var win_condition = [false, false, false, false]

func _process(delta):
	if !win_condition.has(false):
		tile_set.set_layer_eneabled(3, true)
