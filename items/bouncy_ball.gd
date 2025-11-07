extends Item

const FORCE : float = 500
const MAX_BOUNCE : int = 3

var current_bounces = MAX_BOUNCE

var player : PlayerBalloon = null


func initialise(_player : PlayerBalloon) -> void:
	linear_velocity = Vector2.UP.rotated(rotation)*FORCE
	player = _player
	player.apply_impulse(-Vector2.UP.rotated(rotation)*FORCE)
	$Icon.global_rotation = 0


func _on_body_entered(_body: Node) -> void:
	current_bounces -= 1
	%BouncyBounce.play()
	if current_bounces <= 0:
		explode()


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body == player:
		return
	
	if body is PlayerBalloon:
		var hit_direction = (body.global_position - global_position).normalized()
		body.apply_impulse(hit_direction*FORCE)
		body.get_hit()
		explode()
	else:
		printerr("%s touched a player body not a player? (%s)" % [name, body.name])


func explode() -> void:
	queue_free()
