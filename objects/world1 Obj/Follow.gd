extends State

#@onready var birju = owner.get_parent().find_child("Robot")
var distance
var facing = Vector2.ZERO
@onready var warden = owner.get_parent().find_child("Warden")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func enter():
	pass

func walk(facing):
	animationTree["parameters/conditions/walking"] = true
	animationTree["parameters/Walk/blend_position"] = facing

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	distance = birju.position.x - warden.position.x
	facing.x = distance
	if abs(distance)>50:
		walk(facing)
	if abs(distance)<50:
		owner.get_parent().find_child("Warden").velocity.x = 0
		owner.get_parent().find_child("Warden").flag = false
		get_parent().changeState("BatonStrike")
	
