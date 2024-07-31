extends Area2D

func _on_body_entered(body):
	$AnimatedSprite2D.animation = "open"


func _on_body_exited(body):
	$AnimatedSprite2D.animation = "closed"
