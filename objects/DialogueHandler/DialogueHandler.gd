extends Control

@onready var label = $Panel/Label
var dialogueCount = 0
var dialogue1 = ["So you ain't been feelin' too well lately huh?",
				"Well, I changed yer’ brain chip, swapped it for the only one I had.",
				"It was an old one though so it ain’t gonna be the slickest ride, might rattle and hum a bit but it’ll get the job done.",
				"What was that, yer’ hearing buzzing? Well shoot, what’s what I was fearin’.",
				"The chip in your noggins catchin’ a bit of interference. Might be worth lettin’ it settle.",
				"If that don’t help you oughta track down the signal, bound to be something waiting for you there. "]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("next dialogue"):
		label.text = dialogue1[dialogueCount]
		if dialogueCount<len(dialogue1)-1:
			dialogueCount = dialogueCount+1

