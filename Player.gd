extends CharacterBody2D


const START_SPEED = 300.0
const DASH_COOLDOWN = 2.0
var speed = START_SPEED
var canDash = true
var dash_cd = DASH_COOLDOWN
var transporting = false

func _ready():
	transporting = false

func process_input():
	#keyboard input
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * speed
	if Input.is_action_pressed("dash"):
		if canDash:
			position = position + (input_dir.normalized()*1000)
			canDash = false
			$"DashTimer".wait_time = dash_cd
			$"DashTimer".start()

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	process_input()
	if velocity.x > 0:
		$"AnimatedSprite2D".flip_h = true
	elif velocity.x < 0:
		$"AnimatedSprite2D".flip_h = false

	move_and_slide()


func _on_dash_timer_timeout():
	canDash = true

func isTransporting():
	if transporting:
		return true
	else:
		transporting = true
		return false

func set_choords(charr):
	position.x = charr[0]
	position.y = charr[1]

func player():
	pass
