extends State
class_name Shoot

@onready var birju = owner.get_parent().find_child("Robot")
@onready var warden = owner
@onready var animation_tree = $"../../AnimationTree"
@onready var wardensprite = $"../../Warden"
@onready var warden_shoot = $"../../WardenShoot"

var distance
func enter():
	warden.damage = 20
	distance = birju.position.x - warden.position.x
	if(distance > 0):
		facing.x = 1
	elif(distance<0):
		facing.x = -1

	print("Entered Shoot state")
	animation_tree["parameters/conditions/shooting"] = true
	animation_tree["parameters/Shoot/blend_position"] = facing
	await get_tree().create_timer(0.7).timeout
	wardensprite.visible = false
	warden_shoot.visible = true
	animation_tree["parameters/conditions/shooting"] = false
	animation_tree["parameters/conditions/fire"] = true
	animation_tree["parameters/ShootEnd/blend_position"] = facing
	await get_tree().create_timer(0.7).timeout
	transition.emit(self, "Follow")

func exit():
	wardensprite.visible = true
	warden_shoot.visible = false
	animation_tree["parameters/conditions/fire"] = false
	warden.flag = true
