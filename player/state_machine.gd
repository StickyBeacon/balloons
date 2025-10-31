extends Node

@onready var player : PlayerBalloon = $".."

var _is_aiming : bool = false:
	set(value):
		_is_aiming = value
		%AimerNode.visible = value
		%AmmoIcon.visible = not value


func press_button() -> void:
	if _is_aiming:
		shoot()
		%AmmoSwitcher.switch_ammo()
		%AmmoSwitchTimer.start()
	else:
		%AmmoSwitchTimer.stop()
		pass
	_is_aiming = not _is_aiming

func shoot() -> void:
	var item : Item = %AmmoContainer.get_current_item_resource().instantiate()
	ItemContainer.add_child(item)
	item.rotation = %AimerNode.rotation
	item.global_position = player.global_position
	item.initialise(player)
