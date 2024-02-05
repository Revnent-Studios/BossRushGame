extends Node2D
var can_free = false
var dend = false
var nearcar = false
@onready var hint = $"../Hint"
@onready var robot = $"../Robot"

func _physics_process(delta):
	if can_free and dend and Input.is_action_just_released("interact") and nearcar :
		robot.queue_free()
		var travel = create_tween()
		travel.tween_property(self,"position",Vector2(position.x+2000,position.y),3)
		travel.finished.connect(collab)
		can_free = false

func _on_dialogue_handler_dialogue_ended():
	dend = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	can_free = true

func collab():
	if(GlobalVariable.dialogueCounter==0):
		GlobalVariable.dialogueCounter+=1
		get_tree().change_scene_to_file("res://objects/world1 Obj/warden/wardenregion.tscn")
	elif(GlobalVariable.dialogueCounter==1):
		get_tree().change_scene_to_file("res://objects/world2/droneworld.tscn")
	print("done")
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		nearcar = true
	if dend:
		hint.visible = true


func _on_area_2d_body_exited(body):
	hint.visible= false
	nearcar = false
