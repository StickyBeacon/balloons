extends Node

# TODO steek hier alle ammo ofzo.

const item : Resource = preload("res://items/item.tscn")

var item_array : Array[Resource] = [item, item, item]


func change_item(index : int, res : Resource):
	item_array[index] = res


func get_current_item_resource() -> Resource:
	return item_array[%AmmoSwitcher.get_current_index()]
