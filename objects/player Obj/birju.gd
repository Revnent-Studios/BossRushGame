extends CharacterBody2D

# Create an instance of the Movement class
var player_Motion : Movement
var indoors = false
var cutscene = false

func _ready():
	# Instantiate the Movement class
	player_Motion = Movement.new()
	
	# Add the Movement instance as a child of the current node
	add_child(player_Motion)

func _physics_process(delta):
	# Call the methods on the player_Motion instance
	player_Motion.get_gravity(delta,$".")
	if cutscene:
		velocity = Vector2.ZERO
	if not cutscene:
		player_Motion.get_in(delta,$".")
	if not indoors and not cutscene:
		player_Motion.jump(delta,$".")

	# Continue with your other physics process logic
	move_and_slide()


func _on_room_body_entered(body):
	if body == get_node(".") :
		indoors = true
		player_Motion.speed = 225


func _on_door_body_entered(body):
	get_tree().change_scene_to_file("res://objects/cutscenes/OpeningCutscene/ScootersWorkshop.tscn")

func _on_detection_body_entered(body):
		if body == get_node("."):
			#change the cutscene to false after deleting scooter's field with freequeue
			cutscene = true
