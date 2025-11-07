extends RigidBody2D
class_name PlayerBalloon

@export var balloon : BalloonResource
const STARTING_HP : int = 3
var current_hp = STARTING_HP

const hurt_particle = preload("res://particles/player_hurt_particle.tscn")


func _input(event: InputEvent) -> void:
	if (event is InputEventKey or event is InputEventJoypadButton) and event.is_pressed():
		if balloon.action_event == null:
			balloon.action_event = event
		if event.is_match(balloon.action_event):
			%StateMachine.press_button()
			%Overheater.press_button()


func set_balloon(_balloon : BalloonResource):
	balloon = _balloon
	%BalloonBackground.modulate = balloon.player_color
	%CharacterFace.texture = load(PlayerManager.player_faces[balloon.player_face])
	if balloon.items.is_empty():
		return
	for i in range(3):
		%AmmoContainer.change_item(i, balloon.items[i])


func get_hit() -> void:
	
	var part = hurt_particle.instantiate()
	get_tree().current_scene.add_child(part)
	part.global_position = global_position
	
	match current_hp:
		3:
			$PlayerHP3.visible = false
		2:
			$PlayerHP2.visible = false
		_:
			$PlayerHP1.visible = false
	current_hp -= 1
	if current_hp <= 0:
		explode()


func explode() -> void:
	print("%s: I AM DEAD!" % name)
	get_tree().get_first_node_in_group("RoundManager").player_died(self)
	queue_free()
