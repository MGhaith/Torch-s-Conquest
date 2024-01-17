extends CharacterBody2D

var speed = 120

var player_in_area = false
var player

func _ready():
	$AnimatedSprite2D.play("Enemy")

func _physics_process(delta):
	if player_in_area:
		position += (player.position - position) / speed


func _on_detection_area_body_entered(body):
	if body.has_method("is_player"):
		player_in_area = true
		player = body


func _on_detection_area_body_exited(body):
	if body.has_method("is_player"):
		player_in_area = false
