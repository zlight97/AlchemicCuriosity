extends Node

const herbTables = {#weight (cumulative), name
	"longgrass" : [100, "lavender",
					105, "celestial",
					120,  "none"],
	"HouseOutside" : [100, "lavender",
					105, "celestial",
					120,  "none"],
	"small_farm":	[
					100, "lavender",
					102, "celestial"
	],"tallgrass0":	[
					100, "lavender",
					102, "celestial"
	],"tallgrass1":	[
					100, "lavender",
					110, "celestial"
	],"tallgrass2":	[
					100, "lavender",
					115, "celestial"
	],"respite0":	[
					10, "lavender",
					115, "celestial"
	],"respite1":	[
					10, "lavender",
					115, "celestial"
	],"turn0":	[
					100, "lavender",
					140, "celestial",
					150,"none"
	],"turn1":	[
					100, "lavender",
					140, "celestial",
					145,"none"
	],"turn2":	[
					100, "lavender",
					160, "celestial"
	],"boss": [
					100, "none"
	]
}

const spriteChart = {
	"lavender":["res://assets/images/herbs/lavender/lav1.png", "res://assets/images/herbs/lavender/lav2.png", "res://assets/images/herbs/lavender/lav3.png"],
	"celestial":["res://assets/images/herbs/celestial/celestial.png"],
	
	#Mob drops go here
	"snake_fang":["res://assets/images/drops/snake/fang.png"],
	"snake_scale":["res://assets/images/drops/snake/scale.png"],
	"slime_ball":["res://assets/images/drops/slime/slime_ball.png"]
	
}

const invChar = {
	"lavender":"res://assets/images/herbs/lavender/lavInv.png",
	"celestial":"res://assets/images/herbs/celestial/inv.png",
	
	#Mob drops go here
	"snake_fang":"res://assets/images/drops/snake/fang.png",
	"snake_scale":"res://assets/images/drops/snake/scale.png",
	"slime_ball":"res://assets/images/drops/slime/slime_ball.png",
}
