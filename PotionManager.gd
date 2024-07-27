extends Node2D


@export var potion_scene : PackedScene

func _on_player_throw(pos, dest, charSpeed):
	var pot = preload("res://thrown_potion.tscn").instantiate()
	add_child(pot)
	pot.set_choords(pos,dest, charSpeed)
	pot.add_to_group("potions")
