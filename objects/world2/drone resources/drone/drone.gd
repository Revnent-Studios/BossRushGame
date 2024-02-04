extends Node2D
var pos : int
var Ready :bool = true
signal noReady
var Randi = RandomNumberGenerator.new()
var signalno:int
var flipped = false
@onready var sprite_2d = $Sprite2D
@onready var funcs = ["droneIdle","droneDash"]
@export var projectile : PackedScene
@onready var ray_cast_2d = $RayCast2D
var robot
@onready var timer = $Timer

func  _ready():
	if get_tree().has_group("Player"):
		robot = get_tree().get_nodes_in_group("Player")[0]

func _process(delta):
	_aim()
	_check_coll()
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

func _aim():
	if robot!=null:
		ray_cast_2d.target_position = to_local(robot.position)

func _check_coll():
	if ray_cast_2d.get_collider() == robot and timer.is_stopped():
		timer.start()
	if ray_cast_2d.get_collider() != robot and not timer.is_stopped() and Ready:
		timer.stop()

func shoot():
	var bull = projectile.instantiate()
	bull.position = position
	bull.direction = (ray_cast_2d.target_position).normalized()
	get_tree().current_scene.add_child(bull)



func _on_timer_timeout():
	shoot()
	
