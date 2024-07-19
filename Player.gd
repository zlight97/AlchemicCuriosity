extends CharacterBody2D


const START_SPEED = 300.0
var speed = START_SPEED

func process_input():
	#keyboard input
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * speed

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	process_input()
	if velocity.x > 0:
		$"AnimatedSprite2D".flip_h = true
	else:
		$"AnimatedSprite2D".flip_h = false

	move_and_slide()
