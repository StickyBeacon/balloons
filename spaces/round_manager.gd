extends Node


func _ready() -> void:
	var players : Array[BalloonResource] = PlayerManager.get_player_resources()
	if players.is_empty():
		for child : PlayerBalloon in %PlayerContainer.get_children():
			PlayerManager.add_player(child.balloon)
	next_round()


func player_died(node : PlayerBalloon) -> void:
	print("%s: %s just died!" % [name,node.name])
	var players : Array[Node] = %PlayerContainer.get_children()
	
	if players.size() == 2:
		
		ItemContainer.clear_items()
		var winner : PlayerBalloon 
		if players[0] == node:
			winner = players[1]
		else:
			winner = players[0]
		%Laugh.play()
		%WinnerLabel.visible = true
		%WinnerLabel.modulate = winner.balloon.player_color
		await get_tree().create_timer(1).timeout
		%WinnerLabel.visible = false
		ItemContainer.clear_items()
		winner.balloon.points += 1
		print("%s: %s has %s points!" % [name, winner.name, winner.balloon.points])
		if winner.balloon.points >= 3:
			winner.balloon.wins += 1
			print("%s: %s has won the game!" % [name, winner.name])
			end_game()
			return
		next_round()


func end_game() -> void:
	%PlayerContainer.clear_players()
	%WinnerLabel.visible = true
	%WinnerLabel.modulate = PlayerManager.get_winning_player().player_color
	%WinnerLabel2.visible = true
	%WinnerLabel3.visible = true
	print("%s: Game has ended" % name)
	%Laugh.play()
	await get_tree().create_timer(0.1).timeout
	%Laugh.play()
	await get_tree().create_timer(0.1).timeout
	%Laugh.play()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://spaces/main_menu.tscn")


func next_round() -> void:
	%PlayerContainer.clear_players()
	%MapManager.change_map()
	await get_tree().create_timer(1).timeout
	%PlayerContainer.spawn_players()
