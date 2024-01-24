extends Node2D
class_name LightBeam

@onready var line2D = $Line2D
@onready var rayCast2D = $RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	line2D.clear_points()
	
	line2D.add_point(Vector2.ZERO)
	
	# Define initial raycast
	rayCast2D.global_position = line2D.global_position
	rayCast2D.target_position = (Vector2(1,1)) * 1000
	#printt(ta)
	rayCast2D.force_raycast_update()
	
	var prev = null
	
	while true:
		var pt
		if not rayCast2D.is_colliding():
			pt = rayCast2D.global_position + rayCast2D.target_position
			line2D.add_point(line2D.to_local(pt))
			break
		
		var coll = rayCast2D.get_collider()
		pt = rayCast2D.get_collision_point()
		
		line2D.add_point(line2D.to_local(pt))
		
		if not coll.is_in_group("Mirror"):
			break
		
		var normal = rayCast2D.get_collision_normal()
		
		if normal == Vector2.ZERO:
			break
		
		# Update collisions
		if prev != null:
			prev.collision_mask = 3
			prev.collision_layer = 3
		prev = coll
		prev.collision_mask = 0
		prev.collision_layer = 0
		
		# Update raycast
		rayCast2D.global_position = pt
		rayCast2D.target_position = rayCast2D.target_position.bounce(normal)
		rayCast2D.force_raycast_update()
	if prev != null:
		prev.collision_mask = 3
		prev.collision_layer = 3
