extends Area2D

var direction = Vector2.RIGHT
var speed = 200


signal BirjuHit

func _physics_process(delta):
	position += direction*speed*delta



func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.bulletHit = true
		emit_signal("BirjuHit",5)
