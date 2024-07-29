extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/SceneManager").current_scene = $"HouseInside"
	$Player.set_camera_bounds(get_node("/root/MapTables").cameraBounds[$"HouseInside".name])
	var ch = $HouseInside.get_entry_choords(0)
	$Player.set_choords(ch)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
