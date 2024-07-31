extends Area2D

var inMenu = false

func interact(player):
	get_node("/root/SceneManager").create_crafting(player.ingredients)
	player.inMenu = true
	inMenu = true
	if get_node("/root/DialogueTables").teacher_state == 1:
		get_node("/root/DialogueTables").teacher_state += 1

func interact_stop(player):
	if inMenu:
		get_node("/root/SceneManager").clear_crafting()
		#TODO this will be able to skip throw cooldown
		player.inMenu = false
	
