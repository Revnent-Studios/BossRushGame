extends Node

@onready var DodgeTimer =  $Timer

func _dodge(dur):
	DodgeTimer.one_shot=true
	DodgeTimer.autostart =false
	DodgeTimer.wait_time = dur
	DodgeTimer.start()
	
func _is_dodging():
	return !DodgeTimer.is_stopped()
