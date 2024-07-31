extends CharacterBody2D

signal throw_potion
signal took_damage
signal reset

const START_SPEED = 300.0
const DASH_COOLDOWN = .2
const MAX_HP = 100

var current_hp = MAX_HP
var speed = START_SPEED
var dash_cd = DASH_COOLDOWN
var invulnDuration = 0.5
var invuln = false
var inMenu = false

var ingredients = {
	"lavender":0,
	"celestial":0,
}

var canDash = true
var transporting = false
var can_throw = true
var interactable = []

var originalModulate = null

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
	if inMenu:
		return
	if Input.is_action_just_pressed("use"):
		if len(interactable) > 0:
			interactable[0].interact(self)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_throw:
		var dest = get_global_mouse_position()
		#TODO make pot choosing dynamic / picked somehow
		throw_potion.emit("thrown_potion",position, dest, velocity)
		can_throw = false
		$ThrowTimer.start()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and can_throw:
		var dest = get_global_mouse_position()
		#TODO make pot choosing dynamic / picked somehow
		throw_potion.emit("red_potion",position, dest, velocity)
		can_throw = false
		$ThrowTimer.start()

func _physics_process(delta):
	if current_hp <= 0:
		return
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

#TBD how this works
func apply_effect():
	pass

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
	call_deferred("done_transporting")
func done_transporting():
	transporting = false
	
func set_camera_bounds(charr):
	$"PlayerCamera".limit_left = charr[0]
	$"PlayerCamera".limit_top = charr[1]
	$"PlayerCamera".limit_right = charr[2]
	$"PlayerCamera".limit_bottom = charr[3]
	
func damage(amount_hit):
	if !invuln:
		current_hp = current_hp - amount_hit
		invuln = true
		$InvulnTimer.wait_time = invulnDuration
		$InvulnTimer.start()
		originalModulate = modulate
		modulate = Color.RED
		took_damage.emit()
		if current_hp <= 0:
			die()

func reset_vars():
	current_hp = MAX_HP
	speed = START_SPEED
	dash_cd = DASH_COOLDOWN
	invulnDuration = 0.5	
	invuln = false
	canDash = true
	transporting = false
	can_throw = true
	interactable = []
	inMenu = false
	$AnimatedSprite2D.animation = "move1"
	took_damage.emit()
	
func win():
	get_node("/root/DialogueTables").teacher_temp = 1
	reset.emit()
	
func die():
	get_node("/root/DialogueTables").teacher_temp = 0
	reset.emit()

func respawn():
	reset_vars()

func _on_throw_timer_timeout():
	can_throw = true


func _on_interact_box_body_entered(body):
	if body.has_method("interact"):
		interactable.append(body)


func _on_interact_box_body_exited(body):
	var i = interactable.find(body)
	if i>=0:
		interactable[i].interact_stop(self)
		interactable.remove_at(i)


func _on_interact_box_area_entered(area):
	if area.has_method("interact"):
		interactable.append(area)
		


func _on_interact_box_area_exited(area):
	var i = interactable.find(area)
	if i>=0:
		interactable[i].interact_stop(self)
		interactable.remove_at(i)


func _on_invuln_timer_timeout():
	invuln = false
	modulate = originalModulate
