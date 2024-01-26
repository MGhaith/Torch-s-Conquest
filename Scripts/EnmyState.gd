extends State
class_name EnemyState

var speed = 120

@export var enemy: CharacterBody2D
@export var animator: AnimatedSprite2D
@export var ray_cast: RayCast2D
@export var RayCastTimer: Timer

var player
var can_follow = true

func _ready():
	pass
			


func get_ancestor(level: int):
	var parent = self
	
	for x in range(level):
		if parent.get_parent():
			parent = parent.get_parent()
		else:
			return null
			
	return parent
