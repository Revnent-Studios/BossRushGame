extends Control

@onready var label = $Panel/Label
@onready var birju = $".."
var dialogueCount = 0
var allowF = false

var dialogue = [["So you ain't been feelin' too well lately huh?",
				"Well, I changed yer’ brain chip, swapped it for the only one I had.",
				"It was an old one though so it ain’t gonna be the slickest ride, might rattle and hum a bit but it’ll get the job done.",
				"What was that, yer’ hearing buzzing? Well shoot, what’s what I was fearin’.",
				"The chip in your noggins catchin’ a bit of interference. Might be worth lettin’ it settle.",
				"If that don’t help you oughta track down the signal, bound to be something waiting for you there. "],
				["Pardon me Mister, have we met before?",
				"You're saying you're my friend? That's odd, can't quite recall you stranger",
				"Why do you keep pushing this friend nonsense? You can quit the act mister.",
				"So your dang brain chip's still catchin' interference, huh? Well, tough luck, but what's that gotta do with me",
				"I was helping you fix it? Well I wasn't but I suppose it won't hurt to help a stranger in need.",
				"If I had to guess I'd say the chip is catching a bit of interference, I'd track down the signal if I were you",
				"You already did that once? Well damn, do it again then.",
				"Good luck with the chip mister, and please, drop this friend nonsense?"]]

signal dialogueEnded

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(allowF):
		if Input.is_action_just_pressed("next dialogue"):
			if dialogueCount<len(dialogue[GlobalVariable.dialogueCounter]):
				print(dialogueCount)
				label.text = dialogue[GlobalVariable.dialogueCounter][dialogueCount]
				dialogueCount = dialogueCount+1
			else:
				dialogueCount = 1
				emit_signal("dialogueEnded")
				$"../../Scooter/Detection".queue_free()



func _on_detection_body_entered(body):
	if body == $"..":
		allowF = true


func _on_detection_body_exited(body):
	if body == $"..":
		allowF = false
