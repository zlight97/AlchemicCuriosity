extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/SceneManager").current_scene = $"BigDebugWorld"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
