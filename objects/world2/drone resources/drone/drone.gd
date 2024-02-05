extends Node2D
var pos : int
var Ready :bool = true
signal noReady
var Randi = RandomNumberGenerator.new()
var signalno:int
var flipped = false
@onready var lefthit = $Area2D2/CollisionShape2D
@onready var righthit = $Area2D3/CollisionShape2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_2 = $AudioStreamPlayer2D2

@onready var sprite_2d = $Sprite2D
@onready var funcs = ["droneIdle","droneDash"]
@export var projectile : PackedScene
@onready var ray_cast_2d = $RayCast2D
var robot
@onready var timer = $Timer
signal dashing
func  _ready():
	audio_stream_player_2d.play()
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
	if robot.visible and robot != null:
		Ready = false
		var pos = robot.position
		if pos.x<position.x:
			var dashTween = create_tween()
			dashTween.tween_property(self,"position",pos,0.7)
			sprite_2d.flip_h = true
			flipped = true
			dashTween.finished.connect(tweenFinised)
			if dashTween.is_running():
				righthit.disabled = false
				emit_signal("dashing")
			
		if flipped and pos.x>position.x:
			var dashTween = create_tween()
			dashTween.tween_property(self,"position",pos,0.7)
			sprite_2d.flip_h = false
			flipped = false
			dashTween.finished.connect(tweenFinised)
			if dashTween.is_running():
				lefthit.disabled = false
				emit_signal("dashing")
		if !flipped and pos.x>position.x:
			var dashTween = create_tween()
			dashTween.tween_property(self,"position",pos,0.7)
			dashTween.finished.connect(tweenFinised)
			if dashTween.is_running():
				lefthit.disabled = false
				emit_signal("dashing")

func ranSig(noSig:int)->int:
	return Randi.randi_range(0,noSig)

func tweenFinised():
	Ready = true
	sprite_2d.frame = 1
	lefthit.disabled = true
	righthit.disabled = true

func _aim():
	if robot!=null:
		ray_cast_2d.target_position = to_local(robot.position)

func _check_coll():
	if robot!=null:
		if ray_cast_2d.get_collider() == robot and timer.is_stopped() and robot.visible:
			timer.start()
		if ray_cast_2d.get_collider() != robot and not timer.is_stopped() and robot.visible:
			timer.stop()

func shoot():
	if robot.visible:
		audio_stream_player_2d_2.play()
		var bull = projectile.instantiate()
		bull.position = position
		bull.direction = (ray_cast_2d.target_position).normalized()
		get_tree().current_scene.add_child(bull)



func _on_timer_timeout():
	shoot()
	


func _on_dashing():
	sprite_2d.frame = 0
