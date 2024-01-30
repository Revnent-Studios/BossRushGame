extends State
class_name Attack

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
	print("Entered attack state")
	animation_tree["parameters/conditions/melee"] = true
	animation_tree["parameters/Attack/blend_position"] = facing
	await get_tree().create_timer(1.0).timeout
	transition.emit(self, "Follow")

func exit():
	animation_tree["parameters/conditions/melee"] = false
	warden.flag = true
