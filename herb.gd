class_name herb extends Area2D

var herbType = null
var picked = false

func pick():
	picked = true
	hide()
	queue_free()

func setHerbType(infoTable):
	var maxWeight = infoTable[-2]
	var val = randi()%maxWeight
	for i in range(len(infoTable)):
		if i%2 == 1 and infoTable[i-1]>val:
			herbType = infoTable[i]
			return
			 
func setSprite():
	var spriteChart = get_node("/root/HerbTables").spriteChart
	if herbType in spriteChart:
		var sprites = spriteChart[herbType]
		$Sprite2D.texture = load(sprites[randi()%len(sprites)])
	else:
		pick()

# Called when the node enters the scene tree for the first time.
func _ready():
	var infoTable = get_node("/root/HerbTables").herbTables[get_node("/root/SceneManager").current_scene.name]
	if !herbType:
		setHerbType(infoTable)
	setSprite()
	

func interact(player):
	if herbType in player.ingredients:
		player.ingredients[herbType] += 1
	else:
		player.ingredients[herbType] = 1
	pick()

func interact_stop(player):
	pass
