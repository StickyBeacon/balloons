extends Node2D
class_name SelectBalloon

var action_event : InputEvent = null


func initialize(tag : String, event : InputEvent) -> void:
	$Label.text = tag
	scale.x = 1
	scale.y = 1
	action_event = event
