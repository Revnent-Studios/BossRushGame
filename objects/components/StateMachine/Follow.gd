extends State
class_name Follow

@onready var birju = owner.get_parent().find_child("Robot")
@onready var warden = owner
@onready var animation_tree = $"../../AnimationTree"

var distance
var facing = Vector2.ZERO

func enter():
	print("In Follow state rn")

func _process(delta):
	follow()

func follow():
	distance = birju.position.x - warden.position.x
	facing.x = distance
	if(distance<50):
		animation_tree["parameters/conditions/walking"] = true
		animation_tree["parameters/Walk/blend_position"] = facing
