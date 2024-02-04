extends CharacterBody2D
var pos : int
var Ready :bool = true
signal noReady
var Randi = RandomNumberGenerator.new()
var signalno:int
var flipped = false
@onready var sprite_2d = $Sprite2D
@onready var funcs = ["droneIdle","droneDash"]



func _process(delta):
	if Ready:
		var i = ranSig(1)
		call(funcs[i])

func droneIdle():
	Ready = false
	var idleTween
	idleTween = create_tween()
	idleTween.set_loops(5)
	idleTween.tween_property(self,"position",Vector2(position.x,position.y+2),0.5)
	idleTween.tween_property(self,"position",Vector2(position.x,position.y-4),0.5)
	idleTween.finished.connect(tweenFinised)

func droneDash():
	var robot
	if get_tree().has_group("Player"):
		robot = get_tree().get_nodes_in_group("Player")[0]
	if robot!=null:
		Ready = false
		var pos = robot.position
		if pos.x<position.x:
			var dashTween = create_tween()
			dashTween.tween_property(self,"position",pos,0.7)
			sprite_2d.flip_h = true
			flipped = true
			dashTween.finished.connect(tweenFinised)
		if flipped and pos.x>position.x:
			var dashTween = create_tween()
			dashTween.tween_property(self,"position",pos,0.7)
			sprite_2d.flip_h = false
			flipped = false
			dashTween.finished.connect(tweenFinised)
		else:
			var dashTween = create_tween()
			dashTween.tween_property(self,"position",pos,0.7)
			dashTween.finished.connect(tweenFinised)

func ranSig(noSig:int)->int:
	return Randi.randi_range(0,noSig)

func tweenFinised():
	Ready = true

