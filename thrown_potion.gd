class_name thrown_potion extends Area2D

var destPos = null
var weight = .1
var velocity: Vector2
var direction: Vector2
var speed: float = 300.0
var momentum: Vector2
var momentum_scale = .6
var broken = false
var damage = 25
var effect = []
	
func _physics_process(delta):
	position += speed * (direction + momentum.normalized()*momentum_scale) * delta
	
func set_choords(pos,dest,charVel):
	momentum = charVel
	direction = (dest-pos).normalized()
	position = pos
	$AnimatedSprite2D.animation = "thrown"
	$AnimatedSprite2D.play()

func _on_body_entered(body):
	if body.name != "Player":
		break_potion()
		if body.has_method("damage"):
			body.damage(damage)
		if body.has_method("apply_effect"):
			body.apply_effect(effect)

func break_potion():
	broken = true
	splash_ground()
	speed = 0
	$AnimatedSprite2D.animation = "break"
	$AnimatedSprite2D.play()

func splash_ground():
	pass


func _on_animated_sprite_2d_animation_finished():
	if not broken:
		break_potion()
		return
	queue_free()
