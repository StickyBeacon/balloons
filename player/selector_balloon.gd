extends Node2D
class_name SelectorBalloon

var balloon : BalloonResource = null


func initialize(tag : String, _balloon : BalloonResource) -> void:
	$Label.text = tag
	scale.x = 1
	scale.y = 1
	balloon = _balloon
	modulate = balloon.player_color
