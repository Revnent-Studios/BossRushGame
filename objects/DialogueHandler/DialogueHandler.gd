extends Control

@onready var label = $Panel/Label
@onready var birju = $"../Robot"
var dialogueCount = 1
var allowF = false

var dialogue = [["So you ain't been feelin' too well lately huh?",
				"Well, I changed yer’ brain chip, swapped it for the only one I had.",
				"It was an old one though so it ain’t gonna be the slickest ride, might rattle and hum a bit but it’ll get the job done.",
				"What was that, yer’ hearing buzzing? Well shoot, what’s what I was fearin’.",
				"The chip in your noggins catchin’ a bit of interference. Might be worth lettin’ it settle.",
				"If that don’t help you oughta track down the signal, bound to be something waiting for you there. "]]

signal dialogueEnded

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(allowF):
		if Input.is_action_just_pressed("next dialogue"):
			if dialogueCount<len(dialogue[0]):
				print(dialogueCount)
				label.text = dialogue[0][dialogueCount]
				dialogueCount = dialogueCount+1
			else:
				dialogueCount = 1
				emit_signal("dialogueEnded")
				$"../Scooter/Detection".queue_free()



func _on_detection_body_entered(body):
	if body == $"../Robot":
		allowF = true


func _on_detection_body_exited(body):
	if body == $"../Robot":
		allowF = false
