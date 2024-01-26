extends StaticBody2D


@export var interaction_area: InteractionArea
@export var DeathBridgeAreaCollision: CollisionShape2D
@export var tile_map: TileMap
@export var HiddenPathCollision: CollisionShape2D

func _ready():
	$AnimatedSprite2D.play("Inactive")
	interaction_area.interact = Callable(self, "_on_interact")
	
	
func _on_interact():
	$AnimatedSprite2D.play("Active")
	tile_map.set_layer_enabled(2, true)
	if HiddenPathCollision != null:
		HiddenPathCollision.disabled = true
	if DeathBridgeAreaCollision != null:
		DeathBridgeAreaCollision.disabled = true
