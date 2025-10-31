extends Node2D
class_name VoterBalloon

var action_event : InputEvent = null


func initialize(tag : String, event : InputEvent) -> void:
	$Label.text = tag
	action_event = event
