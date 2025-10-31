extends Node2D

const selecter_balloon_res : Resource = preload("res://player/selecter_balloon.tscn")
const player_balloon_res : Resource = preload("res://player/player_balloon.tscn")
const voter_balloon_res : Resource = preload("res://player/voter_balloon.tscn")

const DEFLATE_SPEED : float = 0.5
const MAX_SCALE : float = 5
const MIN_SCALE : float = 0.05

var chosen_events : Array[InputEvent]


func _input(event: InputEvent) -> void:
	var is_allowed = event is InputEventKey \
					or event is InputEventJoypadButton
	
	if is_allowed and event.is_pressed() and not exists_in_chosen_event(event):
		if event is InputEventMouseButton:
			touch_player("%s" % event.button_index, event)
		elif event is InputEventKey:
			touch_player("%s" % event.as_text_keycode(), event)
		elif event is InputEventJoypadButton:
			touch_player("%s, %s" % [event.device,event.button_index], event)


func exists_in_chosen_event(event : InputEvent) -> bool:
	for chosen_event in chosen_events:
		if event.is_match(chosen_event):
			return true
	return false
	


func touch_player(tag : String, event : InputEvent) -> void:
	var children = get_children()
	
	for child in children:
		if child.name == tag:
			increase_size(child,0.3)
			return

	var player : SelectBalloon = selecter_balloon_res.instantiate()
	add_child(player)
	player.global_position = Vector2((randf()-0.5)*300,(randf()-0.5)*300) + Vector2(0,-100)
	player.initialize(tag, event)
	player.name = tag


func increase_size(child : SelectBalloon, amount : float) -> void:
	child.scale.x += amount
	child.scale.y += amount

	if child.scale.x > MAX_SCALE:
		print("%s: I've been chosen!" % name)
		spawn_voter(child)
		child.queue_free()
	elif child.scale.x < MIN_SCALE:
		# TODO POP THE BALLOOn
		child.queue_free()


func _process(delta : float) -> void:
	for child in get_children():
		increase_size(child,-delta*DEFLATE_SPEED)


func spawn_voter(child : SelectBalloon) -> void:
	var voter : VoterBalloon = voter_balloon_res.instantiate()
	voter.initialize(child.name, child.action_event)
	%Voters.add_child(voter)
	voter.position = Vector2((randf()-0.5)*1000, 0)
	chosen_events.push_back(child.action_event)
