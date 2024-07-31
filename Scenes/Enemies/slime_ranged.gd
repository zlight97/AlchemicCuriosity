extends enemy 

func init():
	MAX_HP = 150
	MAX_DAMAGE = 12
	MAX_SPEED = 150
	attackCooldown = 3
	DROP_TABLE = [100, "slime_ball"]
func get_sprite_dir():
	return velocity.x < 0

func create_new_attack(pos, dest):
	var att = preload("res://Scenes/Enemies/Attacks/slime_ranged_attack.tscn").instantiate()
	att.creator = name
	get_node("/root/SceneManager").current_scene.add_child(att)
	att.set_choords(pos,dest, getDamage())


func ranged_attack():
	var type = randi() % 100
	if type < 60:
		create_new_attack(position, player.position)
		if type < 25:
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
		$Sprite.animation = "attack"
		$Sprite.play()
		ranged_attack()
