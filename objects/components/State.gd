extends Node2D

class_name State

@onready var birju = owner.get_parent().find_child("Robot")
@onready var animation_player = owner.find_child("AnimationPlayer")
@onready var debug = owner.find_child("Label")
@onready var animationTree = owner.find_child("AnimationTree")


func _ready():
	set_physics_process(false)
	animationTree.active = true
	
func enter():
	set_physics_process(true)
	
func exit():
	set_physics_process(false)
	
func transition():
	pass

func _physics_process(delta):
	transition()
	debug.text = name 
