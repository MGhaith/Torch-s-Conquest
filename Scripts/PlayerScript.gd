extends CharacterBody2D

@export_category("Nodes")
@export var light : PointLight2D
@export var flashingTimer : Timer
@export var healthTimer : Timer
@export_category("Values")
@export_subgroup("Health")
@export var maxHealth : float = 100.0
@export var damageHealth : float = 1
var playerHealth : float = 100
@export_subgroup("Speed")
@export var maxSpeed : float = 100
@export var acceleration : float = 10 

func _ready():
	randomize()
	healthTimer.wait_time = 1  # Set the timer to trigger every second
	healthTimer.start()

func _process(_delta):
	# Check if the player is still alive
	if playerHealth > 0:
		# Setting moving direction
		var direction = get_input_dir()
		if direction:
			velocity.x = move_toward(velocity.x, maxSpeed * direction.x, acceleration)
			velocity.y = move_toward(velocity.y, maxSpeed * direction.y, acceleration)
		else:
			velocity.x = move_toward(velocity.x, 0, maxSpeed)
			velocity.y = move_toward(velocity.y, 0, maxSpeed)
	else:
		# Implement logic for when the player is out of health (e.g., game over)
		queue_free()

func _physics_process(_delta):
	# Moving the player
	move_and_slide()

# Get the input direction and handle the movement/deceleration.
func get_input_dir() -> Vector2:
	var dir = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	return dir

# Add health 
func addHealth(value : float):
	playerHealth += value
	if playerHealth > maxHealth:
		playerHealth = maxHealth
	printt("Added Health: ", value, " New Health: ", playerHealth)

# Remove health 
func removeHealth(value : float):
	playerHealth -= value
	if playerHealth <= 0:
		queue_free()
		printt("player dead")
	else:
		printt("Damaged Health: ", value, " New Health: ", playerHealth)

# Flashing Light effect
func _on_flashing_light_timer_timeout():
	var rand_amt := (randf())
	light.energy = rand_amt
	if rand_amt < 0.5:
		light.energy = 1
	elif rand_amt > 0.75:
		light.energy = 0.75
	flashingTimer.start(rand_amt / randf_range(1,20))

# Health decrease
func _on_health_decrease_timer_timeout():
	# Decrease player health over time
	playerHealth -= damageHealth

	# Check if the player is still alive
	if playerHealth <= 0:
		playerHealth = 0  # Ensure health doesn't go below 0
		healthTimer.stop()  # Stop the timer when the player runs out of health

	print("Player Health:", playerHealth)
