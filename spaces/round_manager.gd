extends Node


func _ready() -> void:
	var players : Array[BalloonResource] = PlayerManager.get_player_resources()
	if players.size() > 0:
		%PlayerContainer.clear_players()
	%PlayerContainer.spawn_players()
