class_name zone extends TileMap

func _on_area_2d_body_entered(body, id):
	if body.name == "Player":
		body.isTransporting(name, id)

func get_entry_choords(entry_point):
	var n = get_node("EntryNode"+str(entry_point))
	return [n.position.x, n.position.y]
