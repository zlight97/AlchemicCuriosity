extends Area2D

var herbType = null
var picked = false

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
		picked = true
		hide()

# Called when the node enters the scene tree for the first time.
func _ready():
	var infoTable = get_node("/root/HerbTables").herbTables[get_node("/root/SceneManager").current_scene.name]
	setHerbType(infoTable)
	setSprite()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body, n):
	if !picked and body.name == "Player":
		body.herbArea = herbType
		body.herbAreaId = n


func _on_body_exited(body):
	if !picked and body.name == "Player":
		body.herbArea = null
		body.herbAreaId = null
