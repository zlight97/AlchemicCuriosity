class_name enemy extends CharacterBody2D

@onready var main = get_node("/root/Main")
@onready var player = get_node("/root/SceneManager").player

var DROP_TABLE = [100, "none"]

#Constants/base variables
var MAX_HP = 100
var MAX_DAMAGE = 10
var MAX_SPEED = 200
#Stat values
var damage_mod = 1.0
var damage_variance = .25
var current_hp = MAX_HP
var current_speed = MAX_SPEED
#State variables
var alive = true
var attacking = false
var detected = false
var facing = false
var invuln = false
var canSwapDir = true
var invulnTime = .5
var next_animation = "idle"
#Attack timer variables
var attackCooldown = 4.0
var canAttack = true
#Sound Vars
var canPlayMoveSound = true

var poison_counter = 10
var poison_dmg = 0
var originalModulate = null
func init():
	pass

func _ready():
	init()
	$Attack.body_entered.connect(entered_attack)
	$Attack.body_exited.connect(left_attack)
	$Detection.body_entered.connect(entered_detection)
	$Detection.body_exited.connect(left_detection)
	$AttackCD.timeout.connect(attack_cd)
	$InvulnTimer.timeout.connect(invuln_timer)
	$Sprite.animation_looped.connect(sprite_animation_done)
	$PoisonTimer.timeout.connect(poison_tick)
	$AnimationChangeTimer.timeout.connect(update_animation)
	$DirTimer.timeout.connect(allow_swap_dir)

func allow_swap_dir():
	canSwapDir = true

func update_animation():
	$Sprite.animation = next_animation
	$Sprite.play()

func change_animation(animation_name: String):
	if $Sprite.animation == animation_name or animation_name == next_animation or ($Sprite.animation == "hurt" and invuln):
		return
	if animation_name == "hurt":
		$Sprite.animation = "hurt"
		$Sprite.play()
		return
		
	if $AnimationChangeTimer.time_left > 0 and animation_name!=next_animation:
		$AnimationChangeTimer.stop()
	next_animation = animation_name
	$AnimationChangeTimer.start()

func damage(amount_hit):
	if alive:
		if !invuln:
			current_hp -= amount_hit
			invuln = true
			$InvulnTimer.wait_time = invulnTime
			$InvulnTimer.start()
			change_animation("hurt")
		if current_hp <= 0:
			die()
#Dunno how this will work yet, but for applying statuses
func apply_effect(effect):
	for i in range(len(effect)):
		if i%2:
			if effect[i] == "poison":
				apply_poison(effect[i-1])

func apply_poison(amount):
	if poison_counter >= 10:
		originalModulate = modulate
		modulate = Color.SEA_GREEN
	poison_counter = 0
	poison_dmg = amount/10
	$PoisonTimer.wait_time = 5
	$PoisonTimer.start()
func poison_tick():
	poison_counter += 1
	damage(poison_dmg)
	if poison_counter >= 10:
		$PoisonTimer.stop()
		modulate = originalModulate
func is_busy():
	return !alive or attacking or invuln

func ai_process():
	if !alive:
		return
	if attacking:
		attack()
	if detected:
		var direction = (player.position - position)
		direction = direction.normalized()
		velocity = direction * current_speed
	else:
		velocity.x = 0
		velocity.y = 0
func swap_dir():
	if canSwapDir and facing != get_sprite_dir():
		facing = !facing
		scale.x = -1
		canSwapDir = false
		$DirTimer.start()
	
func get_sprite_dir():
	return velocity.x > 0
	
func sound_process():
	pass

func _physics_process(_delta):
	ai_process()
	sound_process()
	if !is_busy():
		if velocity.x == 0 and velocity.y == 0:
			change_animation("idle")
		else:
			change_animation("move")
	if velocity.x != 0:
		swap_dir()
			
	move_and_slide()

func getDamage():
	return round(damage_mod * (MAX_DAMAGE - (MAX_DAMAGE*damage_variance)) + (randf() * MAX_DAMAGE*damage_variance))

func attack():
	if canAttack and not invuln:
		canAttack = false
		$AttackCD.wait_time = attackCooldown
		$AttackCD.start()
		change_animation("attack")
		player.damage(getDamage())

func die():
	velocity.x = 0
	velocity.y = 0
	alive = false
	change_animation("death")

func drop():
	var maxWeight = DROP_TABLE[-2]
	var val = randi()%maxWeight
	for i in range(len(DROP_TABLE)):
		if i%2 == 1 and DROP_TABLE[i-1]>val:
			#Mob drops are just reusing the herb asset, it works the same way
			var new_drop = preload("res://herb.tscn").instantiate()
			new_drop.herbType = DROP_TABLE[i]
			new_drop.position = position
			get_node("/root/SceneManager").current_scene.add_child(new_drop)
			return

func sprite_animation_done():
	if $Sprite.animation == "death":
		drop()
		hide()
		queue_free()
	if $Sprite.animation == "move":
		canPlayMoveSound = true

func entered_attack(body):
	if body.name == "Player":
		attacking = true
func left_attack(body):
	if body.name == "Player":
		attacking = false

func entered_detection(body):
	if body.name == "Player":
		detected = true
	
func left_detection(body):
	if body.name == "Player":
		detected = false

func attack_cd():
	canAttack = true

func invuln_timer():
	invuln = false
