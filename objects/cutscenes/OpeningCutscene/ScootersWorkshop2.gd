extends Node2D
@onready var polygon_2d_3 = $Polygon2D3
@onready var label = $Label
@onready var robot = $Robot

@onready var timer = $Timer

func _ready():
	timer.start()


func _on_timer_timeout():
	robot.queue_free()
	polygon_2d_3.visible = true
	label.visible=true
