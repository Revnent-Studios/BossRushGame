extends Camera2D
@onready var label = $"../Label"

@onready var robot = $"../Robot"

func _physics_process(delta):
	if robot!=null:
		position = robot.position
	if label != null:
		if label.visible:
			position = label.position
