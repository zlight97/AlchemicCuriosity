extends Node

#This Node is strictly for testing capabilities out of sequence, add a key even or some form of trigger and test here

func _ready():
	set_process_input(true)
	
func _input(event):
	if event.is_pressed() and Input.is_key_pressed(KEY_K):
		var dialogueList = ["testdialoguetestdi\naloguetestdialogue","testdial12341234oguetestdialoguetestdialogue","testdialoguetestdialoguetestdialogue1234"]
		get_node("/root/SceneManager").create_dialogue(dialogueList, "This is the name", "res://assets/debugSprite.png")
