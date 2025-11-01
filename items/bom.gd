extends Item
class_name Bom

const FORCE : float = 200
const EXPLODE_FORCE : float = 2000

var player : PlayerBalloon = null


func initialise(_player : PlayerBalloon) -> void:
	linear_velocity = Vector2.UP.rotated(rotation)*FORCE
	player = _player
	player.apply_impulse(-Vector2.UP.rotated(rotation)*FORCE)
	global_rotation = 0


func _on_bom_timer_timeout() -> void:
	explode()


func explode() -> void:
	var balloons = %BomArea.get_overlapping_bodies()
	for balloon : PlayerBalloon in balloons:
		var force_dir = (balloon.global_position - global_position).normalized()
		balloon.apply_central_impulse(force_dir*EXPLODE_FORCE)
		balloon.get_hit()
	queue_free()
