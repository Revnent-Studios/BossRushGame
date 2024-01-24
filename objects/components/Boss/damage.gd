class_name boss

var health = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# setter
func setHealth(hp: int):
	health = hp

# getter
func getHealth():
	return health

func damageTaken(damage):
	health = health-damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
