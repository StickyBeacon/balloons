extends Node2D

const player_res : Resource = preload("res://player/select_balloon.tscn")

const DEFLATE_SPEED : float = 0.5
const MAX_SCALE : float = 5
const MIN_SCALE : float = 0.05

func _input(event: InputEvent) -> void:
	var is_allowed = event is InputEventMouseButton  \
					or event is InputEventKey \
					or event is InputEventJoypadButton
	
	if is_allowed and event.is_pressed():
		if event is InputEventMouseButton:
			touch_player("%s" % event.button_index)
		elif event is InputEventKey:
			touch_player("%s" % event.as_text_keycode())
		elif event is InputEventJoypadButton:
			touch_player("%s, %s" % [event.device,event.button_index])


func touch_player(tag : String) -> void:
	var children = get_children()
	
	for child in children:
		if child.name == tag:
			print("Child found!")
			increase_size(child,0.3)
			return

	var player : SelectBalloon = player_res.instantiate()
	add_child(player)
	player.global_position = Vector2((randf()-0.5)*300,(randf()-0.5)*300)
	player.initialize(tag)
	player.name = tag


func increase_size(child : SelectBalloon, amount : float) -> void:
	child.scale.x += amount
	child.scale.y += amount

	if child.scale.x > MAX_SCALE:
		print("%s: I've been chosen!" % name)
		# TODO POP THE BALLOOn
		child.queue_free()
	elif child.scale.x < MIN_SCALE:
		# TODO POP THE BALLOOn
		child.queue_free()


func _process(delta: float) -> void:
	for child in get_children():
		increase_size(child,-delta*DEFLATE_SPEED)
