class_name Movement
extends CharacterBody2D

# Exported Variables
var speed : float = 500.0
const max_jump_velocity : float = -800.0
const gravity : float = 1960.0
var min_jump_velocity : float = -600.0


# Internal Variables
var jump_ability : bool = true


func get_gravity(delta: float,player:CharacterBody2D) -> void:
	# Add gravity if not on the floor
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
		if Input.is_action_pressed("down"):
			player.velocity.y +=gravity*delta*3

func get_in(delta: float,player:CharacterBody2D) -> bool:
	# Handle horizontal movement
	var direction : float = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * speed
		return true
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		return false
	

func jump(delta: float,player:CharacterBody2D) -> void:
	# Increase jump ability when jump is pressed

	if Input.is_action_just_released("jump"):
		jump_ability = false


	# Adjust jump velocity when jump is held
	if Input.is_action_pressed("jump") and min_jump_velocity > -800 and jump_ability:
		min_jump_velocity -= 6000 * delta
		player.velocity.y = max(max_jump_velocity, min_jump_velocity)
	

	# Reset jump ability when on the floor

	if player.is_on_floor() and !Input.is_action_pressed("jump") and !Input.is_action_pressed("jump"):
		jump_ability = true

	if player.is_on_floor():
		jump_ability = 0
		


