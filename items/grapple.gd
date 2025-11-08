extends Item
class_name Grapple

const SHOOT_FORCE : float = 800
const GRAB_FORCE : float = 3000
var grab_object : Node2D = null
var grab_position : Vector2 = Vector2.ZERO
var player : PlayerBalloon = null
var has_grabbed : bool = false


func initialise(_player : PlayerBalloon) -> void:
	linear_velocity = Vector2.UP.rotated(rotation)*SHOOT_FORCE
	player = _player

const grapple_particle : Resource = preload("res://particles/grapple_particle.tscn")


func explode() -> void:
	queue_free()


func _on_grab_timer_timeout() -> void:
	explode()


func _physics_process(_delta: float) -> void:
	if not player:
		return
	
	if has_grabbed:
		if not player or (not grab_object and grab_position == Vector2.ZERO):
			explode()
			return
	
	%GrappleLine.points[0] = global_position
	%GrappleLine.points[1] = player.global_position
	
	if grab_object:
		global_position = grab_object.global_position
		pull_to_target()
	elif grab_position != Vector2.ZERO:
		global_position = grab_position
		pull_to_target()


func _on_thing_grabber_body_entered(body: Node2D) -> void:
	if has_grabbed:
		return
	
	if body == player or body is Grapple:
		return
		
		
	if not grab_object:
		has_grabbed = true
		%GrabSoundEffect.play()
		if body is PlayerBalloon or body is Item:
			grab_object = body
		else:
			grab_position = global_position
		%GrabTimer.start()
		linear_velocity = Vector2.ZERO
		var part : GPUParticles2D = grapple_particle.instantiate()
		get_tree().current_scene.add_child(part)
		part.global_position = global_position
		part.global_rotation = global_rotation


func pull_to_target() -> void:
	var grab_dir = (global_position - player.global_position).normalized()
	player.apply_central_force(grab_dir*GRAB_FORCE)
