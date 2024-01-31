extends Node

var states : Dictionary = {}
var currentState : State
var lastState : State

@export var initstate : State


func _ready():
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition.connect(on_child_transition)
	if initstate:
		initstate.enter()
		currentState = initstate
	
func _process(delta):
	if currentState:
		currentState.update(delta)
		
func _physics_process(delta):
	if currentState:
		currentState.physicsUpdate(delta)

func  on_child_transition(state, new_state):
	if state!=currentState:
		return
		
	var new = states.get(new_state.to_lower())
	if !new:
		return
		
	if currentState:
		currentState.exit()
	new.enter()
	lastState = currentState
	currentState = new
