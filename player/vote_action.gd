extends Node

@onready var voter : VoterBalloon = $".."
var tween : Tween = null

const SCALE_UP = Vector2(1.2, 1.2)
const SCALE_NORMAL = Vector2(1.0, 1.0)
const DURATION = 0.05


func _input(event: InputEvent) -> void:
	if event.is_match(voter.action_event) and event.is_pressed():
		if tween and tween.is_running():
			tween.kill()
		tween = create_tween()
		tween.tween_property(voter, "scale", SCALE_UP, DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property(voter, "scale", SCALE_NORMAL, DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
