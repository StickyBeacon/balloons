extends Item
class_name Nuke

const FORCE : float = 200
const NUKE_FORCE : float = 50
const EXPLODE_FORCE : float = 2000
const explode_particle : Resource = preload("res://particles/nuke_explode.tscn")

var exploding : bool = false


func initialise(player : PlayerBalloon) -> void:
	linear_velocity = Vector2.UP.rotated(rotation)*NUKE_FORCE
	player.apply_impulse(-Vector2.UP.rotated(rotation)*FORCE)



func explode() -> void:
	if exploding : return
	exploding = true
	print("%s: boom!" % name)
	var balloons = %BomArea.get_overlapping_bodies()
	for balloon : RigidBody2D in balloons:
		if balloon == self:
			continue
		var force_dir = (balloon.global_position - global_position).normalized()
		balloon.apply_central_impulse(force_dir*EXPLODE_FORCE)
		if balloon is PlayerBalloon:
			balloon.get_hit()
	
	var poof = explode_particle.instantiate()
	get_tree().current_scene.add_child(poof)
	poof.global_position = global_position
	
	queue_free()


func _process(_delta: float) -> void:
	$Icon.global_rotation = linear_velocity.angle() - PI/2 + PI


func _on_area_2d_body_entered(_body: Node2D) -> void:
	explode()
