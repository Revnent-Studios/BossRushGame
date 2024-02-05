extends Area2D
var wardenhealth
@onready var robot = $"../Robot"
@onready var core = $Core
@onready var button = $Button
@onready var button_2 = $Button2

func _ready():
	droneIdle()
	visible = false
	
func _physics_process(delta):
	if wardenhealth == 0:
		button.disabled = false
		button_2.disabled = false
		visible = true
func droneIdle():
	var idleTween
	idleTween = create_tween()
	idleTween.set_loops()
	idleTween.tween_property(self,"position",Vector2(position.x,position.y+2),0.5)
	idleTween.tween_property(self,"position",Vector2(position.x,position.y-4),0.5)


func _on_button_pressed():
	queue_free()
	print("Yes")


func _on_button_2_pressed():
	print("no")


func _on_progress_bar_value_changed(value):
	wardenhealth = value
