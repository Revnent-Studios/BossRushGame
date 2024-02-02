extends CharacterBody2D





func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.queue_free()
