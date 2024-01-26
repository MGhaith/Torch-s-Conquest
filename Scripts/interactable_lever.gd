extends StaticBody2D


@export var interaction_area: InteractionArea
@export var DeathBridgeAreaCollision: CollisionShape2D
@export var tile_map: TileMap
@export var HiddenPathCollision: CollisionShape2D
@export var leverSFX : AudioStreamWAV
@export var bridgeSFX : AudioStreamOggVorbis
@export var wallSFX : AudioStreamMP3
var isInteracted : bool = false

func _ready():
	$AnimatedSprite2D.play("Inactive")
	interaction_area.interact = Callable(self, "_on_interact")
	
	
func _on_interact():
	if !isInteracted:
		$AudioStreamPlayer2D.set_stream(leverSFX)
		$AudioStreamPlayer2D.play()
		isInteracted = true
		$AnimatedSprite2D.play("Active")


func _on_audio_stream_player_2d_finished():
	if $AudioStreamPlayer2D.get_stream() == leverSFX:
		if HiddenPathCollision != null:
			$AudioStreamPlayer2D.set_stream(wallSFX)
			$AudioStreamPlayer2D.volume_db = 15
			HiddenPathCollision.disabled = true
		if DeathBridgeAreaCollision != null:
			$AudioStreamPlayer2D.set_stream(bridgeSFX)
			DeathBridgeAreaCollision.disabled = true
		$AudioStreamPlayer2D.play()
		tile_map.set_layer_enabled(2, true)

