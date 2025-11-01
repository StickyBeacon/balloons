extends Node2D

const player_balloon_res : Resource = preload("res://player/player_balloon.tscn")


func clear_players() -> void:
	for child in get_children():
		child.queue_free()


func spawn_players() -> void:
	print_stack()
	for balloon : BalloonResource in PlayerManager.get_player_resources():
		var player : PlayerBalloon = player_balloon_res.instantiate()
		player.set_balloon(balloon)
		add_child(player)
		player.global_position = Vector2((randf()-0.5)*1000, (randf()-0.5)*500)
