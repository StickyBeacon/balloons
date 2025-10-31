extends RigidBody2D
class_name PlayerBalloon

@export var action_event : InputEvent


func _input(event: InputEvent) -> void:
	if (event is InputEventKey or event is InputEventJoypadButton) and event.is_pressed():
		if action_event == null:
			action_event = event
		if event.is_match(action_event):
			%StateMachine.press_button()


func set_action_event(event : InputEvent):
	action_event = event
