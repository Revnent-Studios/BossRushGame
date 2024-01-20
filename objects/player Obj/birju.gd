extends CharacterBody2D

# Create an instance of the Movement class

var indoors = false
var cutscene = false
var player_Motion : Movement
var dodge
var dodgedur = 0.2
var direction : Vector2 = Vector2.ZERO
@onready var animtree : AnimationTree = $AnimationTree


signal _is_invincible

func _ready():
	# Instantiate the Movement class
	player_Motion = Movement.new()
	dodge = $Dodge
	# Add the Movement instance as a child of the current node
	# Turns animation tree on
	animtree.active = true

func _process(delta):
	updateAnimParams()

func _physics_process(delta):
	# Call the methods on the player_Motion instance
	if Input.is_action_just_pressed("dodge"):
		dodge._dodge(dodgedur)
	if dodge._is_dodging():
		emit_signal("_is_invincible")

	player_Motion.get_gravity(delta,$".")
	direction = Input.get_vector("left","right","jump","down").normalized()
	if cutscene:
		velocity.x = 0
	if not cutscene:
		player_Motion.get_in(delta,$".")
	if not indoors and not cutscene:
		player_Motion.jump(delta,$".")
	
	
	# Continue with your other physics process logic
	move_and_slide()

func updateAnimParams():
	if velocity == Vector2.ZERO:
		animtree["parameters/conditions/idle"] = true
		animtree["parameters/conditions/running"] = false
	else:
		animtree["parameters/conditions/idle"] = false
		animtree["parameters/conditions/running"] = true
	print(direction)
	animtree["parameters/Run/blend_position"] = direction
	animtree["parameters/Idle/blend_position"] = direction

func _on_room_body_entered(body):
	if body == get_node(".") :
		indoors = true
		player_Motion.speed = 225


func _on_door_body_entered(body):
	get_tree().change_scene_to_file("res://objects/cutscenes/OpeningCutscene/ScootersWorkshop.tscn")
	



func _on_detection_body_entered(body):
	var dialogueBoxSprite = $"../DialogueHandler"
	if body == get_node("."):
		#change the cutscene to false after deleting scooter's field with freequeue
		cutscene = true
		dialogueBoxSprite.visible = true
		


func _on_dialogue_handler_dialogue_ended():
	var dialogueBoxSprite = $"../DialogueHandler"
	cutscene = false
	dialogueBoxSprite.visible = false


