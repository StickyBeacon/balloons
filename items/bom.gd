extends Item
class_name Bom

const FORCE : float = 200
const EXPLODE_FORCE : float = 2000

var player : PlayerBalloon = null
const explode_particle : Resource = preload("res://particles/bom_explode_particle.tscn")


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
	
	var poof = explode_particle.instantiate()
	get_tree().current_scene.add_child(poof)
	poof.global_position = global_position
	
	queue_free()


func _process(_delta: float) -> void:
	%TextureProgressBar.value = int((1 - (%BomTimer.time_left/3))*100)
