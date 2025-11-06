extends Node

@onready var player : PlayerBalloon = $"../.."


func press_button() -> void:
	shoot()
	%AmmoSwitcher.switch_ammo()


func shoot() -> void:
	var item : Item = %AmmoContainer.get_current_item_resource().instantiate()
	ItemContainer.add_child(item)
	item.rotation = %AimerNode.rotation
	item.global_position = player.global_position
	item.initialise(player)
