extends Area2D

var direction = Vector2.RIGHT
var speed = 200

func _physics_process(delta):
	position += direction*speed*delta



func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
