extends Area2D
@onready var timer = $"../Timer"
@onready var platform_bl = $"../../PlatformBL"

var object
#@onready var birju = owner.get_parent()
@onready var robot = $"../../Robot"

func _on_body_entered(body):
	if body.is_in_group("Player"):
		robot.visible = false
		timer.start()



func _on_timer_timeout():
	robot.position = platform_bl.position
	robot.visible = true
