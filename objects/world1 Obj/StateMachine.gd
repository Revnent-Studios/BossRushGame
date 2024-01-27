extends Node2D


var currentState : State
var prevState : State

# Called when the node enters the scene tree for the first time.
func _ready():
	currentState = get_child(0) as State
	prevState = currentState
	currentState.enter()

func changeState(state):
	currentState = find_child(state) as State
	currentState.enter()
	
	prevState.exit()
	prevState = currentState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
