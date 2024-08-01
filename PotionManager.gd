extends Node2D

@export var potion_scene : PackedScene

const potion_script_map = {
	"thrown_potion":"res://thrown_potion.gd",
	"red_potion":"res://red_potion.gd",
	"poison_potion":"res://poison_potion.gd",
	"shadow_potion":"res://shadow_potion.gd"
}

func _on_player_throw(potName, pos, dest, charSpeed):
	var pot = preload("res://thrown_potion.tscn").instantiate()
	var objId = pot.get_instance_id();
	pot.set_script(load(potion_script_map[potName]));
	pot = instance_from_id(objId);
	get_node("/root/SceneManager").current_scene.add_child(pot)
	pot.set_choords(pos,dest, charSpeed)
	pot.add_to_group("potions")
