extends State
class_name EnemyState

var speed = 120

@export var enemy: CharacterBody2D
@export var animator: AnimatedSprite2D

var player

func _ready():
	animator.play("Enemy")

		
		
func get_ancestor(level: int):
	var parent = self
	
	for x in range(level):
		if parent.get_parent():
			parent = parent.get_parent()
		else:
			return null
			
	return parent	
