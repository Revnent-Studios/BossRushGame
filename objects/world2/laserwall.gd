extends Area2D

func _on_body_entered(body):
	body.is_in_group("Player")
	body.queue_free()
