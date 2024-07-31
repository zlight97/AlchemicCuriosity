extends CanvasLayer

func damage_taken():
	var percent = $"../Player".current_hp / $"../Player".MAX_HP
	var level = floor(percent * 8)
	if level < 0:
		level = 0
	$AnimatedSprite2D.animation = str(level)
