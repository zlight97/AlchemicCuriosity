extends Node

signal respawn

var action = null
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/SceneManager").current_scene = $"HouseInside"
	$Player.set_camera_bounds(get_node("/root/MapTables").cameraBounds[$"HouseInside".name])
	var ch = $HouseInside.get_entry_choords(1)
	$Player.set_choords(ch)

func reset():
	action = "reset"
	$FadeToBlack.start()


func _on_fade_to_black_done_fading():
	if action == "reset":
		get_node("/root/SceneManager").move_zone("Respawn",0)
		respawn.emit()
