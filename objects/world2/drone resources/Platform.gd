extends StaticBody2D
@onready var collision_shape_2d = $CollisionShape2D

func _physics_process(delta):
	if Input.is_action_just_pressed("down"):
		collision_shape_2d.disabled = true
		print("flag")
	if Input.is_action_just_released("down"):
		collision_shape_2d.disabled = false
