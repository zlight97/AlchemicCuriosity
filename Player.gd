extends CharacterBody2D

signal throw_potion
signal took_damage
signal reset
signal transition

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
	"lavender":5,
	"celestial":5,
	"snake_fang":5,
	"snake_scale":5
}

var potions = {
	"health":0,
	"shadow":0,
	"poison":0
}

var canDash = true
var transporting = false
var can_throw = true
var interactable = []

var originalModulate = null

var shadow_loc = null

func item_crafted(item):
	var itemname = item["name"]
	var mats = item["ingredients"]
	var amount = get_node("/root/RecipeTables").craftingAmount[itemname]
	potions[itemname] += amount
	
	for i in range(len(mats)):
		if i % 2 == 1:
			ingredients[mats[i]] = ingredients[mats[i]] - mats[i-1]

func process_input():
	#keyboard input
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * speed
	if Input.is_action_pressed("dash"):
		if canDash and can_throw and potions["shadow"] > 0:
			potions["shadow"] = potions["shadow"] -1
			var dest = get_global_mouse_position()
			throw_potion.emit("shadow_potion",position, dest, velocity)
			$ThrowTimer.start()
			can_throw = false
			canDash = false
		elif !canDash and shadow_loc:
			position = shadow_loc
			shadow_loc = null
			$PlayerCamera.position_smoothing_enabled = true
			$"DashTimer".wait_time = .5
			$"DashTimer".start()
	if inMenu:
		if not get_node("/root/SceneManager").dialogue_scene and  not get_node("/root/SceneManager").crafting_scene:
			inMenu = false
		else:
			return
	if Input.is_action_just_pressed("use"):
		if len(interactable) > 0:
			interactable[0].interact(self)
	if Input.is_action_just_pressed("heal"):
		if MAX_HP > current_hp and potions["health"] > 0:
			current_hp = MAX_HP
			potions["health"] = potions["health"] -1
			took_damage.emit()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_throw:
		var dest = get_global_mouse_position()
		#TODO make pot choosing dynamic / picked somehow
		throw_potion.emit("thrown_potion",position, dest, velocity)
		can_throw = false
		$ThrowTimer.start()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and can_throw and potions["poison"] > 0:
		potions["poison"] = potions["poison"] -1
		var dest = get_global_mouse_position()
		#TODO make pot choosing dynamic / picked somehow
		throw_potion.emit("poison_potion",position, dest, velocity)
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
func apply_effect(effect):
	pass

func _on_dash_timer_timeout():
	canDash = true
	$PlayerCamera.position_smoothing_enabled = false

func isTransporting(zon, id):
	if transporting:
		return true
	else:
		transition.emit(zon, id)
		transporting = true
		return false

func set_choords(charr):
	position.x = charr[0]
	position.y = charr[1]
	shadow_loc = null
	canDash = true
	call_deferred("done_transporting")
func done_transporting():
	$TransitTimer.start()
	
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
	shadow_loc = null
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

func remove_interact(object):
	var i = interactable.find(object)
	if i>=0:
		interactable[i].interact_stop(self)
		interactable.remove_at(i)
		if len(interactable) == 0:
			$useDialogue.hide()

func _on_throw_timer_timeout():
	can_throw = true


func _on_interact_box_body_entered(body):
	if body.has_method("interact"):
		interactable.append(body)
		$useDialogue.show()

func _on_interact_box_body_exited(body):
	remove_interact(body)


func _on_interact_box_area_entered(area):
	if area.has_method("interact"):
		interactable.append(area)
		$useDialogue.show()
		


func _on_interact_box_area_exited(area):
	remove_interact(area)


func _on_invuln_timer_timeout():
	invuln = false
	modulate = originalModulate


func _on_transit_timer_timeout() -> void:
	transporting = false
