extends CharacterBody2D


@export_category("Nodes")
@export var light : PointLight2D
@export var flashingTimer : Timer
@export_category("Values")
@export var maxSpeed : float = 100
@export var acceleration : float = 10 

func _ready():
	randomize()

func _physics_process(_delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = get_input_dir()
	if direction:
		velocity.x = move_toward(velocity.x, maxSpeed * direction.x, acceleration)
		velocity.y = move_toward(velocity.y, maxSpeed * direction.y, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, maxSpeed)
		velocity.y = move_toward(velocity.y, 0, maxSpeed)

	move_and_slide()


func get_input_dir() -> Vector2:
	var dir = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	return dir


func _on_flashing_light_timer_timeout():
	var rand_amt := (randf())
	light.energy = rand_amt
	if rand_amt < 0.5:
		light.energy = 1
	elif rand_amt > 0.75:
		light.energy = 0.75
	flashingTimer.start(rand_amt / randf_range(1,20))
