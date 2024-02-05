extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var warden = boss.new()
var activity = 0
var damage
#@onready var birju = $"../Robot"
@onready var birju = get_parent().find_child("Robot")
@onready var wardenHealthBar = $ProgressBar
@onready var label = $"../Robot/Camera2D/Label"
@onready var animation_player = $"../AnimationPlayer"

signal birjuHit

var flag = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	warden.setHealth(100)

func _process(delta):
	wardenHealthBar.value = warden.getHealth()
	if(warden.getHealth()<=0):
		queue_free()
		
		get_tree().change_scene_to_file("res://objects/cutscenes/OpeningCutscene/ScootersWorkshop.tscn")

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if flag:
		if !activity:
			var direction = birju.position.x - $".".position.x
			if(direction>0):
				velocity.x=SPEED
			else:
				velocity.x=-SPEED

	
	move_and_slide()

func _on_robot_weapon_hit():
	warden.damageTaken(randi_range(7,15))


func _on_hitbox_body_entered(body):
	if body == birju:
		emit_signal("birjuHit",damage)
