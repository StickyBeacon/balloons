extends Node2D
class_name VoterBalloon

var balloon : BalloonResource = null


func initialize(tag : String, _balloon : BalloonResource) -> void:
	$Label.text = tag
	balloon = _balloon
	modulate = balloon.player_color


func explode() -> void:
	queue_free()
	get_tree().get_first_node_in_group("InputChecker").remove_voter(balloon)


func is_voting() -> bool:
	return not %VoteTimer.is_stopped()
