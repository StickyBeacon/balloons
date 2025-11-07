extends Node

@onready var player : PlayerBalloon = $"../.."

const poof_particle : Resource = preload("res://particles/poof_particle.tscn")



func press_button() -> void:
	shoot()
	%AmmoSwitcher.switch_ammo()


func shoot() -> void:
	var item : Item = %AmmoContainer.get_current_item_resource().instantiate()
	ItemContainer.add_child(item)
	item.rotation = %AimerNode.rotation
	item.global_position = player.global_position
	item.initialise(player)
	
	var poof : GPUParticles2D = poof_particle.instantiate()
	get_tree().current_scene.add_child(poof)
	poof.modulate = %AimerNode.modulate
	poof.global_position = %AimerNode.global_position
	poof.global_rotation = %AimerNode.global_rotation
