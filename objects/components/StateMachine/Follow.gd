extends State
class_name Follow

@onready var birju = owner.get_parent().find_child("Robot")
@onready var warden = owner
@onready var animation_tree = $"../../AnimationTree"

var distance


func enter():
	animation_tree["parameters/conditions/walking"] = true
	print("Entered follow state")

func update(delta):
	follow()
	
func exit():
	warden.flag = false
	warden.velocity.x = 0
	animation_tree["parameters/conditions/walking"] = false
	print("Exited follow state")

func follow():
	distance = birju.position.x - warden.position.x
	if(distance > 0):
		facing.x = 1
	elif(distance<0):
		facing.x = -1
	animation_tree["parameters/conditions/walking"] = true
	animation_tree["parameters/Walk/blend_position"] = facing
	if(abs(distance)<50):
		transition.emit(self,"Attack")

	
