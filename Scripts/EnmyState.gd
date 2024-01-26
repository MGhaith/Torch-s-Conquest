extends State
class_name EnemyState

var speed = 120

@export var enemy: CharacterBody2D
@export var animator: AnimatedSprite2D
@export var ray_cast: RayCast2D
@export var RayCastTimer: Timer

const FACING = {
	Vector2(1, 0): 'right',
	Vector2(-1, 0): 'left',
	Vector2(0, -1): 'down',
	Vector2(0, 1): 'up',
}

var animation_direction
var player

func _ready():
	pass
			


func get_facing_vector(vec_to_player):
	var min_angle = 360
	var facing = Vector2()
	for vec in FACING.keys():
		var ang = abs(vec_to_player.angle_to(vec))
		if ang < min_angle:
			min_angle = ang
			facing = vec
	return facing
	
	
func get_facing_direction(vec_to_player):
	var facing_vec = get_facing_vector(vec_to_player)
	return FACING[facing_vec]
	

func get_ancestor(level: int):
	var parent = self
	
	for x in range(level):
		if parent.get_parent():
			parent = parent.get_parent()
		else:
			return null
			
	return parent
