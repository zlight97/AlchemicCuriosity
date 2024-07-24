extends Node

const BigDebugWorld = [
	["res://debug_world.tscn",1],
	["res://debug_world.tscn",0]
]

const DebugWorld = [
	["res://big_debug_world.tscn",0],
	["res://big_debug_world.tscn",1]
]

const cameraBounds = {
	"DebugWorld":[0,0,1155,640],
	"BigDebugWorld":[-800,-496,2352,1328]
}

func get_map_dest(entry_name, entry_loc):
	return self[entry_name][entry_loc]
	#TODO get some kind of eval to refrence the given map table based on name
	#TODO needs some way to determine procedural as well
