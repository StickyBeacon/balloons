extends Node2D
class_name SelectorBalloon

var balloon : BalloonResource = null


func initialize(_balloon : BalloonResource) -> void:
	scale.x = 1
	scale.y = 1
	balloon = _balloon
	$Icon2.modulate = balloon.player_color
	%CharacterFace.texture = load(PlayerManager.player_faces[balloon.player_face])


func pop()->void:
	%Noise.pitch_scale = 0.5*scale.x
	%Noise.play()
