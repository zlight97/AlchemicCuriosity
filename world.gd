extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body, id):
	if body.name == "Player":
		get_node("/root/SceneManager").move_zone(name,id)

func get_entry_choords(entry_point):
	var n = get_node("EntryNode"+str(entry_point))
	return [n.position.x, n.position.y]
