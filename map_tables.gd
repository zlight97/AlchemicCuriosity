extends Node

const BigDebugWorld = [
	["res://longgrass.tscn",1],
	["res://longgrass.tscn",0]
]

const DebugWorld = [
	["res://big_debug_world.tscn",0],
	["res://big_debug_world.tscn",1]
]

const HouseOutside = [
	["res://longgrass.tscn",2],
	["res://house_inside.tscn",0]
]

const HouseInside = [
	["res://house_outside.tscn",1]
]

const longgrass = [
	["res://big_debug_world.tscn",0],
	["res://big_debug_world.tscn",1],
	["res://house_outside.tscn",0]
]

const cameraBounds = {
	"DebugWorld":[0,0,1155,640],
	"BigDebugWorld":[-800,-496,2352,1328],
	"longgrass":[0,0,3500,1200],
	"HouseOutside":[0,0,1200,700],
	"HouseInside":[-400,-400,1200,800]
}

func get_map_dest(entry_name, entry_loc):
	return self[entry_name][entry_loc]
	#TODO get some kind of eval to refrence the given map table based on name
	#TODO needs some way to determine procedural as well
