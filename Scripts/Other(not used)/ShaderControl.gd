extends Node2D

@export var player : CharacterBody2D
@export var shaderRect : ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player_pos = player.global_position
	player_pos = (player_pos / Vector2(get_viewport().size))
	shaderRect.material.set_shader_parameter("mouse_position", player_pos)
