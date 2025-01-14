extends enemy 

func init():
	$PitchAudioStreamPlayer.init(.93, 1.08, .05, 1)
	MAX_HP = 70
	current_hp = MAX_HP
	MAX_DAMAGE = 12
	MAX_SPEED = 180
	attackCooldown = 1
	DROP_TABLE = [100, "none",
					120, "slime_ball"]
func get_sprite_dir():
	return velocity.x < 0

func sound_process():
	if $Sprite.animation == "move" and not $PitchAudioStreamPlayer.playing and $Sprite.frame == 0:
		$PitchAudioStreamPlayer.play_pitched()
		canPlayMoveSound = false
