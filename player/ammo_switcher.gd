extends Node

var _colors : Array[Color] = [Color.RED, Color.BLUE, Color.GREEN] 
var _current_index : int = 0:
	set(value):
		_current_index = value
		%AmmoIcon.modulate = _colors[_current_index]


func _on_ammo_switch_timer_timeout() -> void:
	switch_ammo()


func switch_ammo() -> void:
	_current_index = (_current_index + 1) % _colors.size()
	print(_current_index)


func get_current_index() -> int:
	return _current_index
