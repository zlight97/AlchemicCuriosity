extends Node

var teacher_state = 0
var teacher_temp = -1

const teacher = [
	["Hey, welcome in, I'm supposed to tell you about the world\nand set up a dark and gloomy scene.","However someone got a little too overzelous and didn't finish the\ntheme of the game. You might not find me as shadowy as I was supposed to be.","Anyway, you can left click to throw a potion, right click to throw a different potion\npress shift to throw a different potion, and E to drink a potion.","Real complex right? Heres a simple damaging potion, for plot reasons you always seem to have one.","You want more potions? Go look at the cauldron over there.\nTry using with F"],
	["Use F to interact with things... \nHow did you ask me this if you didnt know that?"],
	["How can I see my inventory?","You ever played dungeons and dragons?","Use paper and your imagination."],
	["Go out and find some herbs so we can get brewing!\nSometimes monsters will drops things you need too!","When you leave and enter zones herbs spring right back up!","The devloper said having them not do that took too much time..."]
]
const teacher_random = [
	["Go out and find some herbs so we can get brewing!\nSometimes monsters will drops things you need too!","When you leave and enter zones herbs spring right back up!","The devloper said having them not do that took too much time..."]
]
const teacher_tempA = [
	["Hey I collected you from some field out there, be more careful. \nThere shouldnt be anything stronger than a slime or two"],
	["Hey you beat a slime or two, good shit. Maybe you can explore elsewhere sometime"]
]

func get_dialogue(person):
	if self[person+"_temp"] > -1:
		var i = self[person+"_temp"]
		self[person+"_temp"] = -1
		return self[person+"_tempA"][i]
	var i = self[person][self[person+"_state"]] if self[person+"_state"] < len(self[person]) else self[person+"_random"][randi()%len(self[person+"_random"])]
	return i
	
