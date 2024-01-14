extends CharacterBody2D


const SPEED = 500.0
var JUMP_VELOCITY_Max = -800.0
var JUMP_VELOCITY_MIN = -600.0
var jumpAbility = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1960


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		jumpAbility+=1
	if Input.is_action_pressed("jump") and JUMP_VELOCITY_MIN>-800 and jumpAbility<1:
		JUMP_VELOCITY_MIN-=6000*delta
		velocity.y = max(JUMP_VELOCITY_Max,JUMP_VELOCITY_MIN)
	if is_on_floor():
		jumpAbility = 0
		
	if Input.is_action_just_released("jump"):
		JUMP_VELOCITY_MIN =0.0		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
