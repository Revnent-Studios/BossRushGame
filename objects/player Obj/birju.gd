extends CharacterBody2D

# Create an instance of the Movement class
var player_Motion : Movement
var indoors = false

func _ready():
	# Instantiate the Movement class
	player_Motion = Movement.new()
	
	# Add the Movement instance as a child of the current node
	add_child(player_Motion)

func _physics_process(delta):
	# Call the methods on the player_Motion instance
	player_Motion.get_gravity(delta,$".")
	player_Motion.get_in(delta,$".")
	if not indoors:
		player_Motion.jump(delta,$".")

	# Continue with your other physics process logic
	move_and_slide()


func _on_room_body_entered(body):
	indoors = true
	pass # Replace with function body.
