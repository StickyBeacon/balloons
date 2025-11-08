extends Node2D
class_name VoterBalloon

var balloon : BalloonResource = null


func initialize(_balloon : BalloonResource) -> void:
	balloon = _balloon
	$Icon.modulate = balloon.player_color
	%CharacterFace.texture = load(PlayerManager.player_faces[balloon.player_face])


func explode() -> void:
	queue_free()
	get_tree().get_first_node_in_group("InputChecker").remove_voter(balloon)


func is_voting() -> bool:
	return not %VoteTimer.is_stopped()
