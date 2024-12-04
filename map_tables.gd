extends Node

const Respawn = [
	["res://Maps/house_inside.tscn",1]
]

const HouseOutside = [
	["res://longgrass.tscn",2],
	["res://Maps/house_inside.tscn",0]
]

const HouseInside = [
	
	["res://Maps/house_outside.tscn",1]
]

const longgrass = [
	["res://Maps/small_farm.tscn",0],
	["res://Maps/tall_grass0.tscn",0],
	["res://Maps/house_outside.tscn",0]
]

const small_farm = [
	["res://longgrass.tscn",1]
]

const tallgrass0 = [
	["res://Maps/tall_grass1.tscn",0]
]

const tallgrass1 = [
	["res://Maps/tall_grass2.tscn",0]
]

const tallgrass2 = [
	["res://Maps/respite.tscn",0]
]

const respite0 = [
	["res://Maps/turn0.tscn",0]
]

const turn0 = [
	["res://Maps/turn1.tscn",0]
]
const turn1 = [
	["res://Maps/turn2.tscn",0]
]
const turn2 = [
	["res://Maps/respite1.tscn",0]
]
const respite1 = [
	["res://Maps/boss.tscn",0]
]

const cameraBounds = {
	"longgrass":[0,0,3500,1200],
	"HouseOutside":[0,0,1200,700],
	"HouseInside":[-400,-400,1200,800],
	"small_farm":[0,0,1200,700],
	"tallgrass0":[0,0,1200,1800],
	"tallgrass1":[0,0,1200,1800],
	"tallgrass2":[0,0,1200,1800],
	"respite0":[0,0,1200,900],
	"respite1":[0,0,1200,900],
	"turn0":[0,0,2400,1700],
	"turn1":[0,0,2400,1700],
	"turn2":[0,0,2400,1700],
	"boss":[0,0,1200,700],
}

func get_map_dest(entry_name, entry_loc):
	return self[entry_name][entry_loc]
	#TODO get some kind of eval to refrence the given map table based on name
	#TODO needs some way to determine procedural as well
