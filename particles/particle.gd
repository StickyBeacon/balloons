extends GPUParticles2D


var self_destruct_time = lifetime

func _ready() -> void:
	emitting = true
	one_shot = true

func _process(delta: float) -> void:
	self_destruct_time -= delta
	if self_destruct_time <= 0:
		queue_free()
