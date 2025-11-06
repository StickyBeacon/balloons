extends Node

var _colors : Array[Color] = [Color.RED, Color.GREEN, Color.BLUE] 
var _current_index : int = 0:
	set(value):
		_current_index = value
		%AimerNode.modulate = _colors[_current_index]


func switch_ammo() -> void:
	_current_index = (_current_index + 1) % _colors.size()


func get_current_index() -> int:
	return _current_index
