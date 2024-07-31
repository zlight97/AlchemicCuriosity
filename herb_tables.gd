extends Node

const herbTables = {#weight (cumulative), name
	"longgrass" : [100, "lavender",
					105, "celestial",
					120,  "none"],
	"HouseOutside" : [100, "lavender",
					105, "celestial",
					120,  "none"],
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
