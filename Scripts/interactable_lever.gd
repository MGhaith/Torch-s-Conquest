extends StaticBody2D


@export var interaction_area: InteractionArea
@export var DeathBridgeAreaCollision: CollisionShape2D
@export var tile_map: TileMap

func _ready():
	$AnimatedSprite2D.play("Inactive")
	interaction_area.interact = Callable(self, "_on_interact")
	
	
func _on_interact():
	tile_map.set_layer_enabled(1, true)
	if DeathBridgeAreaCollision != null:
		DeathBridgeAreaCollision.disabled = true