extends Node

# TODO steek hier alle ammo ofzo.

const bouncy_ball : Resource = preload("res://items/bouncy_ball.tscn")
const grapple : Resource = preload("res://items/grapple.tscn")
const bom : Resource = preload("res://items/bom.tscn")

var item_array : Array[Resource] = [bom, bouncy_ball, grapple]


func change_item(index : int, res : Resource):
	item_array[index] = res


func get_current_item_resource() -> Resource:
	return item_array[%AmmoSwitcher.get_current_index()]
