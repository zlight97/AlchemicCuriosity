extends Node

signal respawn

var action = null
var newZone = null
var newEntrance = null
# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().get_root()
	var scene = root.get_node("Main")
	
	get_node("/root/SceneManager").move_zone("Respawn",0)

func reset():
	action = "reset"
	$FadeToBlack.start(2)

func transition(zon, entrance):
	if action == null:
		action = "trans"
		newZone = zon
		newEntrance = entrance
		$FadeToBlack.start(.5)

func _on_fade_to_black_done_fading():
	if action == "reset":
		get_node("/root/SceneManager").move_zone("Respawn",0)
		respawn.emit()
		action = null
	elif action == "trans":
		get_node("/root/SceneManager").move_zone(newZone, newEntrance)
		action = null
		$Player.done_transporting()
