extends CharacterBody2D

var idle = true
var dir = 2
var talking = true
const SPEED = 100.0

func _physics_process(delta):
	move_and_slide()


func _on_idle_move_timer_timeout():
	idle = !idle
	if !idle:
		dir = randi()%4
		$AnimatedSprite2D.animation = "walk" + str(dir)
		$IdleMoveTimer.wait_time = randf() * 3
		if dir == 0:
			velocity.y = -1 * SPEED
		elif dir == 1:
			velocity.x = 1 * SPEED
		elif dir == 2:
			velocity.y = 1 * SPEED
		elif dir == 3:
			velocity.x = -1 * SPEED
	else:
		$AnimatedSprite2D.animation = "idle" + str(dir)
		velocity.x = 0
		velocity.y = 0
		$IdleMoveTimer.wait_time = randf() * 10
	$IdleMoveTimer.start()

func talk():
	idle = true
	talking = true
	velocity.x = 0
	velocity.y = 0
	$AnimatedSprite2D.animation = "idle2"
	$IdleMoveTimer.stop()
	var dialogueList = ["testdialoguetestdi\naloguetestdialogue","testdial12341234oguetestdialoguetestdialogue","testdialoguetestdialoguetestdialogue1234"]
	get_node("/root/SceneManager").create_dialogue(dialogueList, "Teacher", "res://assets/images/sprites/teacher_sprite/teacher_dialogue.tres")

func interact(player):
	talk()

func interact_stop():
	if talking:
		talking = false
		$IdleMoveTimer.start()
		get_node("/root/SceneManager").clear_dialogue()
