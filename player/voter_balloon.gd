extends Node2D
class_name VoterBalloon

var balloon : BalloonResource = null

const hurt_particle = preload("res://particles/player_hurt_particle.tscn")

func initialize(_balloon : BalloonResource) -> void:
	balloon = _balloon
	$Icon.modulate = balloon.player_color
	%CharacterFace.texture = load(PlayerManager.player_faces[balloon.player_face])


func explode() -> void:
	var part = hurt_particle.instantiate()
	part.modulate = balloon.player_color
	get_tree().current_scene.add_child(part)
	part.global_position = global_position
	get_tree().get_first_node_in_group("InputChecker").remove_voter(balloon)
	queue_free()


func is_voting() -> bool:
	return not %VoteTimer.is_stopped()
