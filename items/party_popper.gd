extends Particle

const POP_FORCE : float = 500
const OFFSET : float = 100
const MOVE_SPEED : float = 400


func initialise(_balloon) -> void:
	pass


func _physics_process(_delta: float) -> void:
	global_position += transform.basis_xform(Vector2(0,-1))*MOVE_SPEED*_delta
	pop()


func pop() -> void:
	for player in $Area2D.get_overlapping_bodies():
		if player is RigidBody2D:
			var force_dir = (player.global_position - global_position).normalized()
			player.apply_central_impulse(force_dir*POP_FORCE)
