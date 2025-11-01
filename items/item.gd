extends RigidBody2D
class_name Item


func initialise(player : PlayerBalloon) -> void:
	printerr("%s: Initialised empy Item by %s" % [name, player.name])


func explode() -> void:
	printerr("%s: Exploding empty item" % name)
	queue_free()
