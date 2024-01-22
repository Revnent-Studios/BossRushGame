class_name boss

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# setter
func setHealth(hp):
	health = hp

# getter
func getHealth():
	return health
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
