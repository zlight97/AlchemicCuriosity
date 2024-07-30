class_name enemy extends CharacterBody2D

@onready var main = get_node("/root/main")
@onready var player = get_node("/root/main/Player")

#Constants/base variables
const MAX_HP = 100
const MAX_DAMAGE = 10
const MAX_SPEED = 200
#Stat values
var damage_mod = 1.0
var damage_variance = .25
var current_hp = MAX_HP
var current_speed = MAX_SPEED
#State variables
var alive = true
var attacking = false
var detected = false
var invuln = false
var invulnTime = .5
#Attack timer variables
var attackCooldown = 4.0
var canAttack = true

func _ready():
	$Attack.body_entered.connect(entered_attack)
	$Attack.body_exited.connect(left_attack)
	$Detection.body_entered.connect(entered_detection)
	$Detection.body_exited.connect(left_detection)
	$AttackCD.timeout.connect(attack_cd)
	$InvulnTimer.timeout.connect(invuln_timer)

func damage(amount_hit):
	if !invuln:
		current_hp -= amount_hit
		invuln = true
		$Collisions.disabled = true
		$InvulnTimer.wait_time = invulnTime
		$InvulnTimer.start()
		$Sprite.animation = "hurt"
		$Sprite.start()
	if current_hp <= 0 and alive:
		die()
		
func is_busy():
	return !alive or attacking or invuln

func ai_process():
	if !alive:
		return
	if attacking:
		attack()

func _physics_process(delta):
	ai_process()
	if !is_busy():
		if velocity.x == 0 and velocity.y == 0 and $Sprite.animation != "idle":
			$Sprite.animation = "idle"
			$Sprite.play()
		elif $Sprite.animation != "move":
			$Sprite.animation = "move"
			$Sprite.play()
			
	move_and_slide()

func getDamage():
	return damage_mod * (MAX_DAMAGE - (MAX_DAMAGE*damage_variance)) + (randi() % (MAX_DAMAGE*damage_variance))

func attack():
	if canAttack and not invuln:
		canAttack = false
		$AttackCD.wait_time = attackCooldown
		$AttackCD.start()
		$Sprite.animation = "attack"
		$Sprite.play()
		player.damage(getDamage())

func die():
	alive = false
	$Sprite.animation = "death"
	$Sprite.play()
	queue_free()

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
	$Collisions.disabled = false
	invuln = false
