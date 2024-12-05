extends AudioStreamPlayer

var pitch_low = .8
var pitch_hi = 1.2
var lastPitch = 1
var pitch_min_diff = .1

func play_pitched(from_position=0.0):
	while abs(lastPitch - pitch_scale) < pitch_min_diff:
		pitch_scale = randf_range(pitch_low, pitch_hi)
	lastPitch = pitch_scale
	
	play(from_position)

func set_pitches(low=.8,high=1.2,diff=.1):
	pitch_low = low
	pitch_hi = high
	pitch_min_diff = diff
