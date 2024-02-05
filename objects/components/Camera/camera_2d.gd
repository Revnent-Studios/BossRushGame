extends Camera2D

@onready var robot = $"../Robot"

func _physics_process(delta):
	if robot!=null:
		position = robot.position
