extends Node

var player_dict : Array[BalloonResource]


func add_player(balloon_resource : BalloonResource):
	player_dict.append(balloon_resource)


func get_player_resources() -> Array[BalloonResource]:
	return player_dict
