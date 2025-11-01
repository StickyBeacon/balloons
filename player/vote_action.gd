extends Node

@onready var voter : VoterBalloon = $".."
var tween : Tween = null

const SCALE_UP = Vector2(1.2, 1.2)
const SCALE_NORMAL = Vector2(1.0, 1.0)
const DURATION = 0.05

const MAX_HEAT = 0.5
const HEAT_INCREASE_AMOUNT : float = 0.2
var heat : float = 0


func _input(event: InputEvent) -> void:
	if event.is_match(voter.balloon.action_event) and event.is_pressed():
		pop()
		heat += HEAT_INCREASE_AMOUNT
		%VoteTimer.start()


func pop() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(voter, "scale", SCALE_UP, DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(voter, "scale", SCALE_NORMAL, DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)


func _process(delta: float) -> void:
	if heat > MAX_HEAT:
		voter.explode()
	
	if heat > 0:
		heat -= delta
