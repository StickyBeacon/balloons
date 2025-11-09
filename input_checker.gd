extends Node2D

const selector_balloon_res : Resource = preload("res://player/selector_balloon.tscn")
const player_balloon_res : Resource = preload("res://player/player_balloon.tscn")
const voter_balloon_res : Resource = preload("res://player/voter_balloon.tscn")

const DEFLATE_SPEED : float = 0.5
const MAX_SCALE : float = 5
const MIN_SCALE : float = 0.05

var chosen_balloons : Array[BalloonResource]


func _ready() -> void:
	if not PlayerManager.player_dict.is_empty():
		for player : BalloonResource in PlayerManager.player_dict:
			spawn_voter(player)
		PlayerManager.clear_players()


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
	for chosen_balloon : BalloonResource in chosen_balloons:
		if event.is_match(chosen_balloon.action_event):
			return true
	return false
	


func touch_player(tag : String, event : InputEvent) -> void:
	var children = %SelectorContainer.get_children()
	
	for child in children:
		if child.name == tag:
			increase_size(child,0.3)
			child.pop()
			return

	var player : SelectorBalloon = selector_balloon_res.instantiate()
	%SelectorContainer.add_child(player)
	player.global_position = Vector2((randf()-0.5)*800,(randf()-0.5)*300) + Vector2(0,-100)
	player.initialize(generate_new_balloon(event))
	player.name = tag
	player.pop()


func increase_size(child : SelectorBalloon, amount : float) -> void:
	child.scale.x += amount
	child.scale.y += amount

	if child.scale.x > MAX_SCALE:
		print("%s: I've been chosen!" % name)
		spawn_voter(child.balloon)
		child.queue_free()
	elif child.scale.x < MIN_SCALE:
		# TODO POP THE BALLOOn
		child.queue_free()


func generate_new_balloon(event : InputEvent) -> BalloonResource:
	var balloon = BalloonResource.new()
	balloon.action_event = event
	balloon.player_color = Color(randf()*0.8 + 0.1,randf()*0.8 + 0.1,randf()*0.8 + 0.1)
	balloon.player_face = randi_range(0,11)
	return balloon


func _process(delta : float) -> void:
	deflate_selectors(delta)
	check_for_start_game()
	
	
func deflate_selectors(delta : float) -> void:
	for child in %SelectorContainer.get_children():
		increase_size(child,-delta*DEFLATE_SPEED)


func check_for_start_game() -> void:
	var will_start_game : bool = true
	var voters = %VoterContainer.get_children()
	if voters.size() < 2:
		return
	
	for child : VoterBalloon in  voters:
		if not child.is_voting():
			will_start_game = false
	if will_start_game:
		start_game()


func start_game() -> void:
	for balloon : BalloonResource in chosen_balloons:
		PlayerManager.add_player(balloon)
	get_tree().change_scene_to_file("res://spaces/world.tscn")


func spawn_voter(balloon : BalloonResource) -> void:
	var voter : VoterBalloon = voter_balloon_res.instantiate()
	voter.initialize(balloon)
	%VoterContainer.add_child(voter)
	voter.position = Vector2((randf()-0.5)*1000, 0)
	chosen_balloons.push_back(balloon)


func remove_voter(balloon : BalloonResource) -> void:
	chosen_balloons.erase(balloon)
