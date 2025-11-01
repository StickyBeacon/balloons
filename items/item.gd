extends RigidBody2D
class_name Item


func initialise(player : PlayerBalloon) -> void:
	printerr("%s: unimplemented initialise by %s" % [name, player.name])


func explode() -> void:
	printerr("%s: unimplemented explode item" % name)
	queue_free()
