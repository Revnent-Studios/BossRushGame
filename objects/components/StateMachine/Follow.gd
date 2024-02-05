extends State
class_name Follow

@onready var birju = owner.get_parent().find_child("Robot")
@onready var warden = owner
@onready var animation_tree = $"../../AnimationTree"

var distance


func enter():
	warden.flag = true
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
	print(distance)
	animation_tree["parameters/conditions/walking"] = true
	animation_tree["parameters/Walk/blend_position"] = facing
	if(abs(distance)<50):
		transition.emit(self,"Attack")
	elif(abs(distance)>700):
		transition.emit(self,"Dash")
	elif(abs(distance)>150 and abs(distance) <200):
		transition.emit(self,"Shoot")
	
