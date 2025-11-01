extends Node

const MAX_HEAT = 0.5
const HEAT_INCREASE_AMOUNT : float = 0.2
var heat : float = 0

@onready var player : PlayerBalloon = $"../.."


func press_button() -> void:
	heat += HEAT_INCREASE_AMOUNT


func _process(delta: float) -> void:
	if heat > MAX_HEAT:
		player.explode()
	
	if heat > 0:
		heat -= delta
