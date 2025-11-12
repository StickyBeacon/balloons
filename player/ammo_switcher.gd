extends Node

var _colors : Array[Color] = [Color.RED, Color.GREEN, Color.BLUE, Color.CYAN, Color.MAGENTA, Color.YELLOW] 
var _current_index : int = 4:
	set(value):
		_current_index = value
		%AimerNode.modulate = _colors[_current_index]


func switch_ammo() -> void:
	_current_index = (_current_index + randi_range(1,_colors.size()-1)) % _colors.size()


func get_current_index() -> int:
	return _current_index
