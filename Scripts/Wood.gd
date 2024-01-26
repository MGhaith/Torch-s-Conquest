extends Sprite2D

var taken : bool = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		if !taken:
			taken = true
			body.addHealth(30)
			self.visible = false
			$AudioStreamPlayer.play()


func _on_audio_stream_player_finished():
	queue_free()
