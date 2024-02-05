extends CharacterBody2D

# Create an instance of the Movement class
var birjesh = boss.new()
var indoors = false
var cutscene = false
var player_Motion : Movement
var dodge
var dodgedur = 0.2
var timer
var direction : Vector2 = Vector2.ZERO
var facing : Vector2 = Vector2.ZERO
var jumping 
var _on_door
var running 
var flag = true
@onready var animation_player = $"../AnimationPlayer"
@onready var animtree : AnimationTree = $AnimationTree
@onready var animplayer: AnimationPlayer = $AnimationPlayer
@onready var birjuSprite = $Birju
@onready var birjuHealthBar = $ProgressBar

signal weaponHit

func _ready():
	# Instantiate the Movement class
	player_Motion = Movement.new()
	dodge = $Dodge
	# Add the Movement instance as a child of the current node
	# Turns animation tree on
	animtree.active = true
	$WeaponHitbox/Hitbox.disabled = true
	birjesh.setHealth(100)

func _process(delta):
	if birjuHealthBar != null:
		birjuHealthBar.value = birjesh.getHealth()
	updateAnimParams()
	jumping = is_on_floor()
	if(birjesh.getHealth()<=0):
		birjuHealthBar.visible = false
		flag = false
		birjuSprite.visible = false
		animation_player.play("youdied")
		await get_tree().create_timer(4.0).timeout
		get_tree().reload_current_scene()

func _physics_process(delta):
	if flag:
		# Call the methods on the player_Motion instance
		if Input.is_action_just_released("interact") and _on_door:
			get_tree().change_scene_to_file("res://objects/cutscenes/OpeningCutscene/ScootersWorkshop.tscn")
		if Input.is_action_just_pressed("dodge"):
			dodge._dodge(dodgedur)
		if Input.is_action_just_pressed("attack"):
			attack("sword")
		if dodge._is_dodging():
			emit_signal("_is_invincible")
		
		player_Motion.get_gravity(delta,$".")
		direction = Input.get_vector("left","right","jump","down").normalized()
		if(direction[0]>0):
			facing.x = 1
		elif(direction[0]<0):
			facing.x = -1
		
		if cutscene:
			velocity.x = 0
		if not cutscene:
			player_Motion.get_in(delta,$".")
		if not indoors and not cutscene:
				player_Motion.jump(delta,$".")
		
		
		# Continue with your other physics process logic
		move_and_slide()

func updateAnimParams():
	animtree["parameters/conditions/idle"] = false
	
	
	if velocity == Vector2.ZERO and !Input.is_anything_pressed():
		animtree["parameters/conditions/idle"] = true
		animtree["parameters/conditions/running"] = false
	elif(velocity.x!=0):
		animtree["parameters/conditions/idle"] = false
		if $".".is_on_floor():
			running = true
			animtree["parameters/conditions/running"] = true
	if Input.is_action_just_pressed("attack"):
		animtree["parameters/conditions/attacking"] = true
		await get_tree().create_timer(0.2).timeout
		animtree["parameters/conditions/attacking"] = false
	if Input.is_action_just_pressed("jump"):
		if jumping and player_Motion.jump_ability: 
			animtree["parameters/conditions/jumping"] = true
		animtree["parameters/conditions/running"] = false
	if $".".velocity.y>0 and !is_on_floor():
		animtree["parameters/conditions/jumping"] = false
		animtree["parameters/conditions/falling"] = true
		animtree["parameters/conditions/running"] = false
	if $".".is_on_floor():
		animtree["parameters/conditions/falling"] = false
	
	animtree["parameters/Run/blend_position"] = facing
	animtree["parameters/Idle/blend_position"] = facing
	animtree["parameters/Attack/blend_position"] = facing
	animtree["parameters/Jump/blend_position"] = facing
	animtree["parameters/Fall/blend_position"] = facing


func attack(weapon):
	pass

func _on_room_body_entered(body):
	if body == get_node(".") :
		indoors = true
		player_Motion.speed = 225

func _on_door_body_entered(body):
	_on_door = true



func _on_detection_body_entered(body):
	var dialogueBoxSprite = $DialogueHandler
	if body == get_node("."):
		#change the cutscene to false after deleting scooter's field with freequeue
		cutscene = true
		dialogueBoxSprite.visible = true

func _on_dialogue_handler_dialogue_ended():
	var dialogueBoxSprite = $DialogueHandler
	cutscene = false
	dialogueBoxSprite.visible = false


func _on_weapon_hitbox_body_entered(body):
	if(body==$"../Warden"):
		emit_signal("weaponHit")


func _on_door_body_exited(body):
	_on_door = false


func _on_warden_birju_hit(damage):
	birjesh.damageTaken(damage)
