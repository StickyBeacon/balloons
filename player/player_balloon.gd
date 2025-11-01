extends RigidBody2D
class_name PlayerBalloon

@export var balloon : BalloonResource
const STARTING_HP : int = 3
var current_hp = STARTING_HP


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
	if balloon.items.is_empty():
		return
	for i in range(3):
		%AmmoContainer.change_item(i, balloon.items[i])


func get_hit() -> void:
	print("%s: Ow! I've been hit!" % name)
	current_hp -= 1
	if current_hp <= 0:
		explode()


func explode() -> void:
	print("%s: I AM DEAD!")
	queue_free()
