extends CharacterBody2D

@export_category("Nodes")
@export var light : PointLight2D
@export var flashingTimer : Timer
@export var healthTimer : Timer
@export var light_nodes : Node2D
@export var flameAreaCollision : CollisionShape2D
@export_category("Values")
@export_subgroup("Health")
@export var maxHealth : float = 100.0
@export var damageHealth : float = 2
var playerHealth : float = 100
@export_subgroup("Speed")
@export var maxSpeed : float = 30
@export var acceleration : float = 5 
var canMove : bool = true
@export_category("Audio")
@export var audioPlayer : AudioStreamPlayer
@export_category("Animation")
@export var animPlayer : AnimationPlayer

func _ready():
	randomize()

func _process(_delta):
	# Check if the player is still alive
	if playerHealth > 0:
		# Check for Skills action
		if Input.is_action_just_pressed("Sprint") && !Input.is_action_pressed("SkillB"):
			FireSprint()
		if Input.is_action_just_pressed("SkillB") && !Input.is_action_pressed("Sprint"):
			SkillB()
		if (Input.is_action_just_released("Sprint") && !Input.is_action_pressed("SkillB")) or (Input.is_action_just_released("SkillB") && !Input.is_action_pressed("Sprint")):
			SkillReset()
		
		# Setting moving direction
		var direction = get_input_dir()
		
		if direction != Vector2.ZERO:
			if !audioPlayer.playing:
				audioPlayer.play()
		else:
			audioPlayer.stop()
		
		if direction:
			velocity.x = move_toward(velocity.x, maxSpeed * direction.x, acceleration)
			velocity.y = move_toward(velocity.y, maxSpeed * direction.y, acceleration)
			if direction.y < 0:
				animPlayer.play("walk-top")
			elif direction.y > 0:
				animPlayer.play("walk-down")
			if direction.x < 0:
				if direction.y < 0:
					animPlayer.play("walk-top")
				elif direction.y > 0:
					animPlayer.play("walk-down")
				else:
					animPlayer.play("walk-left")
			elif direction.x > 0:
				if direction.y < 0:
					animPlayer.play("walk-top")
				elif direction.y > 0:
					animPlayer.play("walk-down")
				else:
					animPlayer.play("walk-right")
		else:
			animPlayer.seek(0)
			velocity.x = move_toward(velocity.x, 0, maxSpeed)
			velocity.y = move_toward(velocity.y, 0, maxSpeed)
	else:
		# Implement logic for when the player is out of health (e.g., game over)
		velocity.x = move_toward(velocity.x, 0, maxSpeed)
		velocity.y = move_toward(velocity.y, 0, maxSpeed)
		


func _physics_process(_delta):
	# Moving the player
	if canMove:
		move_and_slide()

# Get the input direction and handle the movement/deceleration.
func get_input_dir() -> Vector2:
	var dir = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	return dir

# Health Decrease
func StartHealthTimer():
	healthTimer.wait_time = 1 # Set the timer to trigger every second
	healthTimer.start()

# Add health 
func addHealth(value : float):
	playerHealth += value
	if playerHealth > maxHealth:
		playerHealth = maxHealth

# Remove health 
func removeHealth(value : float):
	playerHealth -= value
	$EnemyHitPlayer.play()

# Sprinting Skill
func FireSprint():
	light.texture_scale = 2.5
	damageHealth = 3
	flameAreaCollision.set_scale(Vector2(1.1, 1.1))
	maxSpeed = 50

#SkillB
func SkillB():
	light.texture_scale = 1
	damageHealth = 1
	flameAreaCollision.set_scale(Vector2(0.5, 0.5))
	maxSpeed = 10

# No-Skill reset
func SkillReset():
	light.texture_scale = 2
	damageHealth = 2
	flameAreaCollision.set_scale(Vector2(1, 1))
	maxSpeed = 30

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
