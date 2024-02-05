extends Sprite2D
@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("scooterji")

func Anime():
	var chalo = create_tween()
	chalo.set_loops()
	chalo.tween_property(self,"frame",5,2)
