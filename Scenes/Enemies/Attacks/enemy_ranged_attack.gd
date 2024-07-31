class_name enemy_ranged_attack extends Area2D

var creator = null
var velocity: Vector2
var direction: Vector2
var speed: float = 400.0
var broken = false
var damage = 5
var ttl = 1.0

func init():
	$AnimatedSprite2D.animation_looped.connect(_on_animated_sprite_2d_animation_looped)
	body_entered.connect(_on_body_entered)
func _ready():
	$TTL.timeout.connect(hit)
	init()

func _physics_process(delta):
	position += speed * direction * delta

func check_dir():
	return direction.x < 0
	
func set_choords(pos,dest,dmg):
	damage = dmg
	direction = (dest-pos).normalized()
	position = pos
	if check_dir():
		scale.x = -1
	$AnimatedSprite2D.animation = "flying"
	$AnimatedSprite2D.play()
	$TTL.wait_time = ttl
	$TTL.start()

func _on_body_entered(body):
	if !creator or not creator == body.name:
		hit()
	if body.name == "Player":
		body.damage(damage)
		body.apply_effect()

func hit():
	broken = true
	speed = 0
	$AnimatedSprite2D.animation = "done"
	$AnimatedSprite2D.play()

#Used to spawn pools or something if we want
func apply_death():
	pass

func _on_animated_sprite_2d_animation_looped():
	if $AnimatedSprite2D.animation == "done":
		apply_death()
		queue_free()
