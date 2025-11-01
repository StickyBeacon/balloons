extends Node2D

const maps : Array[Resource] = [preload("res://spaces/basic_map.tscn"), preload("res://spaces/maps/map_1.tscn")]


func change_map() -> void:
	print("%s: new map!" % name)
	for child in get_children():
		child.queue_free()
	
	var new_map = maps.pick_random().instantiate()
	call_deferred("add_child",new_map)
