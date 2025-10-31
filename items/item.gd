extends RigidBody2D
class_name Item

const FORCE : float = 500

func initialise(player : PlayerBalloon) -> void:
	linear_velocity = Vector2.UP.rotated(rotation)*FORCE
	player.apply_impulse(-Vector2.UP.rotated(rotation)*FORCE)
