extends enemy 

func init():
	MAX_HP = 70
	current_hp = MAX_HP
	MAX_DAMAGE = 12
	MAX_SPEED = 180
	attackCooldown = 1
	DROP_TABLE = [100, "none",
					120, "slime_ball"]
func get_sprite_dir():
	return velocity.x < 0
