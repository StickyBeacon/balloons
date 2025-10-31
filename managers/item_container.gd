extends Node


func clear_items() -> void:
	for item in get_children():
		item.queue_free()
