extends CharacterBody2D

signal throw_potion

const START_SPEED = 300.0
const DASH_COOLDOWN = 2.0

var ingredients = {
	"lavender":0,
	"test":0
}
var herbArea = null
var speed = START_SPEED
var canDash = true
var dash_cd = DASH_COOLDOWN
var transporting = false
var can_throw = true

func _ready():
	transporting = false

func process_input():
	#keyboard input
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * speed
	if Input.is_action_pressed("dash"):
		if canDash:
			$PlayerCamera.position_smoothing_enabled = true
			position = position + (input_dir.normalized()*500)
			canDash = false
			$"DashTimer".wait_time = dash_cd
			$"DashTimer".start()
			
	if Input.is_action_just_pressed("use"):
		gatherHerb()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_throw:
		var dest = get_global_mouse_position()
		throw_potion.emit(position, dest, velocity)
		can_throw = false
		$ThrowTimer.start()

func gatherHerb():
	if herbArea:
		if herbArea.herbType in ingredients:
			ingredients[herbArea.herbType] += 1
		else:
			ingredients[herbArea.herbType] = 1
		herbArea.pick()
		herbArea = null

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	process_input()
	move_and_slide()
	if velocity.x < 0:
		$AnimatedSprite2D.animation = "move2"
	elif velocity.x > 0:
		$AnimatedSprite2D.animation = "move0"
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "move3"
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "move1"
	
	if velocity.length() != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1


func _on_dash_timer_timeout():
	canDash = true
	$PlayerCamera.position_smoothing_enabled = false

func isTransporting():
	if transporting:
		return true
	else:
		transporting = true
		return false

func set_choords(charr):
	position.x = charr[0]
	position.y = charr[1]

func set_camera_bounds(charr):
	$"PlayerCamera".limit_left = charr[0]
	$"PlayerCamera".limit_top = charr[1]
	$"PlayerCamera".limit_right = charr[2]
	$"PlayerCamera".limit_bottom = charr[3]
	


func _on_throw_timer_timeout():
	can_throw = true
