extends Label

func _ready():
	droneIdle()

func droneIdle():
	var idleTween
	idleTween = create_tween()
	idleTween.set_loops()
	idleTween.tween_property(self,"position",Vector2(position.x,position.y+2),0.5)
	idleTween.tween_property(self,"position",Vector2(position.x,position.y-4),0.5)





func _on_door_body_entered(body):
	visible = true


func _on_door_body_exited(body):
	visible = false
