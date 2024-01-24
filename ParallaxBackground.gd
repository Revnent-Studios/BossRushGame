extends ParallaxBackground

@onready var clouds = $ParallaxLayer

func _physics_process(delta):
	clouds.motion_offset.x += 10*delta
