extends CharacterBody2D

#region Constants&Variables
const MOVEMENT_SPEED = 500.0
const max_jump_velocity = -800.0
const  gravity = 1960
var min_jump_velocity = -600.0
var jump_ability = 0
#endregion


#region DriverCode
func _physics_process(delta):
	# Add gravity if not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jumping
	jump(delta)

	# Handle horizontal movement
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * MOVEMENT_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVEMENT_SPEED)

	# Move and slide to handle collisions
	move_and_slide()
#endregion

func jump(delta):
	# Increase jump ability when jump is pressed
	if Input.is_action_just_pressed("jump"):
		jump_ability += 1

	# Adjust jump velocity when jump is held
	if Input.is_action_pressed("jump") and min_jump_velocity > -800 and jump_ability < 1:
		min_jump_velocity -= 6000 * delta
		velocity.y = max(max_jump_velocity, min_jump_velocity)

	# Reset jump ability when on the floor
	if is_on_floor():
		jump_ability = 0

	# Reset jump velocity when jump is released
	if Input.is_action_just_released("jump"):
		min_jump_velocity = 0.0

#TODO
#Add Dash Mechanic
