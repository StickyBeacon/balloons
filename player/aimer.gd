extends Node

const ROTATE_SPEED : float = 2*PI


func _physics_process(delta: float) -> void:
	%AimerNode.rotate(delta*ROTATE_SPEED)
