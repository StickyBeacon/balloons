extends Node

var player_dict : Array[BalloonResource]
var player_faces : Array[String] = \
["res://assets/images/face_angry.png" , \
"res://assets/images/face_bored.png" , \
"res://assets/images/face_dead.png" , \
"res://assets/images/face_droopy.png" , \
"res://assets/images/face_eye.png" , \
"res://assets/images/face_god.png" , \
"res://assets/images/face_hmmrnngg.png" , \
"res://assets/images/face_ohmo.png" , \
"res://assets/images/face_robot.png" , \
"res://assets/images/face_smile.png" , \
"res://assets/images/face_spooky.png" , \
"res://assets/images/face_tired.png" ]


func add_player(balloon_resource : BalloonResource):
	player_dict.append(balloon_resource)


func get_player_resources() -> Array[BalloonResource]:
	return player_dict
