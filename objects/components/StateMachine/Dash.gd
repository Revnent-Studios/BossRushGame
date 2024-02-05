extends State
class_name Dash

@onready var birju = owner.get_parent().find_child("Robot")
@onready var warden = owner
@onready var animation_tree = $"../../AnimationTree"
var distance

func enter():
	distance = birju.position.x - warden.position.x
	if(distance > 0):
		facing.x = 1
	elif(distance<0):
		facing.x = -1
	print("Entered Dash state")
	animation_tree["parameters/conditions/dash"] = true
	animation_tree["parameters/Dash/blend_position"] = facing
	if facing.x == 1:
		warden.velocity.x= 500
	elif facing.x == -1:
		warden.velocity.x = -500
	await get_tree().create_timer(3.0).timeout
	if(abs(distance)>50):
		transition.emit(self,"Follow")
	else:
		transition.emit(self,"Attack")

func exit():
	animation_tree["parameters/conditions/dash"] = false
	warden.flag = true
