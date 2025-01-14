extends enemy 


func init():
	$AttackSound.init(.90, 1.01, .05, 1)
	MAX_HP = 1000
	current_hp = MAX_HP
	MAX_DAMAGE = 15
	MAX_SPEED = 150
	attackCooldown = 3
	DROP_TABLE = [100, "slime_ball"]
func get_sprite_dir():
	return velocity.x < 0

func die():
	velocity.x = 0
	velocity.y = 0
	alive = false
	change_animation("death")
	player.win()

func damage(amount_hit):
	if alive:
		if !invuln:
			current_hp -= amount_hit
			invuln = true
			if current_hp < 200:
				attackCooldown = 1.
			elif current_hp < 400:
				attackCooldown = 1.5
			$InvulnTimer.wait_time = invulnTime
			$InvulnTimer.start()
			change_animation("hurt")
		if current_hp <= 0:
			die()

func create_new_attack(pos, dest):
	var att = preload("res://Scenes/Enemies/Attacks/slime_ranged_attack.tscn").instantiate()
	att.creator = name
	get_node("/root/SceneManager").current_scene.add_child(att)
	att.set_choords(pos,dest, getDamage())


func ranged_attack():
	var type = randi() % 100
	if type < 60:
		create_new_attack(position, player.position)
		if type < 50:
			var angle = position.angle_to_point(player.position)
			var length = position.distance_to(player.position)
			var vec1 = Vector2(position.x + cos(angle+.35) * length, position.y + sin(angle+.35) * length)
			var vec2 = Vector2(position.x + cos(angle-.35) * length, position.y + sin(angle-.35) * length)
			create_new_attack(position, vec1)
			create_new_attack(position, vec2)
	else:
		#Predict movement based on velocity
		var destV = player.position + player.velocity
		var t = player.position.distance_to(destV) - destV.distance_to(position)
		var destPos = player.position + (player.velocity.normalized() * t) if t> 0 else destV
		create_new_attack(position, destPos)

func ai_process():
	if !alive:
		return
	if attacking:
		attack()
	if detected:
		if not attacking:
			var direction = (player.position - position)
			direction = direction.normalized()
			velocity = direction * current_speed
		else:
			var direction = (position - player.position)
			direction = direction.normalized()
			velocity = direction * current_speed * .2
	else:
		velocity.x = 0
		velocity.y = 0

func attack():
	if canAttack and not invuln:
		canAttack = false
		$AttackCD.wait_time = attackCooldown
		$AttackCD.start()
		change_animation("attack")
		$AttackSound.play_pitched()
		ranged_attack()
		
func sound_process():
	if $Sprite.animation == "move" and $Sprite.frame == 0:
		canPlayMoveSound = false
