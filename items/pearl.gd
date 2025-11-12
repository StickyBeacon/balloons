extends Item

const FORCE : float = 50
const poof_particle : Resource = preload("res://particles/pearl_particle.tscn")
var player : PlayerBalloon


func initialise(_player : PlayerBalloon) -> void:
	linear_velocity = Vector2.UP.rotated(rotation)*FORCE
	player = _player
	player.apply_impulse(Vector2.UP.rotated(rotation)*FORCE)
	global_rotation = 0
	


func explode() -> void:
	if not player:
		return
	_teleport(player, global_position, player.linear_velocity)
	
	var poof = poof_particle.instantiate()
	get_tree().current_scene.add_child(poof)
	poof.global_position = global_position
	
	queue_free()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	explode()


func _teleport(object : RigidBody2D, _position : Vector2, _velocity : Vector2 = Vector2.ZERO, angularVelocity : float = 0.0, isSleeping : bool = false) -> void:
	var id = object.get_rid()
	object.global_transform = Transform2D.IDENTITY.translated(_position)
	PhysicsServer2D.body_set_state(id, PhysicsServer2D.BODY_STATE_TRANSFORM, Transform2D.IDENTITY.translated(position))
	object.linear_velocity = _velocity
	PhysicsServer2D.body_set_state(id, PhysicsServer2D.BODY_STATE_LINEAR_VELOCITY, _velocity)
	object.angular_velocity = angularVelocity
	PhysicsServer2D.body_set_state(id, PhysicsServer2D.BODY_STATE_ANGULAR_VELOCITY, angularVelocity)
	object.sleeping = isSleeping
	PhysicsServer2D.body_set_state(id, PhysicsServer2D.BODY_STATE_SLEEPING, isSleeping)
